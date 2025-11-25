import os
import uuid
from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from PyPDF2 import PdfReader
import pytesseract
import pdf2image
from PIL import Image
from langchain_groq import ChatGroq
import re

# Tesseract OCR
pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"

# Groq LLM
llm = ChatGroq(
    model="llama-3.1-8b-instant",
    temperature=0.2
)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],   # IMPORTANT — allow Flutter & Android
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


def extract_text_from_file(file_path):
    ext = file_path.lower()

    if ext.endswith(".pdf"):
        text = ""
        try:
            reader = PdfReader(file_path)
            for page in reader.pages:
                text += page.extract_text() or ""
        except:
            text = ""

        if not text.strip():
            images = pdf2image.convert_from_path(file_path)
            for image in images:
                text += pytesseract.image_to_string(image)

        return text

    elif ext.endswith(".jpg") or ext.endswith(".jpeg") or ext.endswith(".png"):
        image = Image.open(file_path)
        text = pytesseract.image_to_string(image)
        return text

    else:
        raise Exception("Unsupported file format")


def analyze_report_text(text):
    prompt = f"""

You are a medical AI analyzing a patient's laboratory/health diagnostic report.

Extracted text:
{text}

Return output in this exact format:

1. 🩺 Summary
2. 🔎 Key findings
3. ⚠️ Potential risks
4. 🩻 Interpretation of abnormal values
5. 💊 Recommended next actions
6. 👨‍⚕️ Follow-up medical advice

7. 🧠 Explainability Insights (XAI)
👉 Here you must show EXACT CAUSE-REASON mapping:
- Quote REAL values from report
- Explain HOW EXACTLY each value influenced the conclusion
Example:
"Hemoglobin = 8.2 (low) → Suggests iron-deficiency anemia"
"WBC = 14K (elevated) → Indicates possible infection"
"Vitamin D = 9 ng/mL (severe deficiency) → Associated with fatigue & bone pain"

8. 🎯 Disease-Specific Risk Estimation
Return EXACTLY these:

🫁 Lung Cancer Risk: NN%
🧠 Brain Cancer Risk: NN%
🩸 Anemia Risk: NN%
🧬 Colon Cancer Risk: NN%
🫀 Heart Disease Risk: NN%

IMPORTANT:
At the VERY END return:

HEALTH_SCORE = NN

Only the integer number must be after '='
No extra text.

"""
    response = llm.invoke(prompt)
    return getattr(response, "content", str(response))


# Extract SCORE
def extract_score(ai_text):
    match = re.search(r"HEALTH_SCORE\s*=\s*(\d+)", ai_text)
    return int(match.group(1)) if match else 70


# Extract disease risks using regex
def extract_disease_risk(ai_text, disease_name):
    pattern = rf"{disease_name} Risk[: ]+(\d+)%"
    match = re.search(pattern, ai_text)
    return int(match.group(1)) if match else None


@app.post("/analyze")
async def analyze_endpoint(file: UploadFile = File(...)):
    file_ext = file.filename.split(".")[-1]
    filename = f"{uuid.uuid4()}.{file_ext}"

    with open(filename, "wb") as f:
        f.write(await file.read())

    extracted_text = extract_text_from_file(filename)
    ai_result = analyze_report_text(extracted_text)

    score = extract_score(ai_result)

    lung = extract_disease_risk(ai_result, "Lung Cancer")
    brain = extract_disease_risk(ai_result, "Brain Cancer")
    anemia = extract_disease_risk(ai_result, "Anemia")
    colon = extract_disease_risk(ai_result, "Colon Cancer")
    heart = extract_disease_risk(ai_result, "Heart Disease")


    os.remove(filename)

    return JSONResponse({
        "success": True,
        "analysis": ai_result,
        "health_score": score,
        "disease_risk": {
            "lung_cancer": lung,
            "brain_cancer": brain,
            "anemia": anemia,
            "colon_cancer": colon,
            "heart_disease": heart
        }
    })
