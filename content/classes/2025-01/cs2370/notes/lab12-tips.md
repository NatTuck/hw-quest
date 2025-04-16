---
title: "cs2370 Notes: Lab12 Tips"
date: "2025-04-15"
---

## Model List and Pointers from Grok

- facebook/mbart-large-50-many-to-many-mmt (Transformers)
  - Task: Multilingual text translation (e.g., English to Japanese, French to Hindi)
  - Why Fun: Translate text across 50+ languages for global chat or creative writing.
  - Pointers: Use pipeline("translation"), set torch_dtype=torch.float16, and move to cuda. Limit input length to ~128 tokens to save VRAM.
- google/owlvit-base-patch32 (Transformers)
  - Task: Open-vocabulary object detection (detect objects in images from text prompts)
  - Why Fun: Identify custom objects in photos (e.g., "red mug" or "striped cat") interactively.
  - Pointers: Use OwlViTProcessor and OwlViTForObjectDetection. Preprocess images to 512x512, use fp16, and batch size 1.
- facebook/detr-resnet-50 (Transformers)
  - Task: Object detection in images (bounding boxes and labels)
  - Why Fun: Visualize objects in photos with bounding boxes for interactive analysis.
  - Pointers: Load with DetrForObjectDetection, use fp16, and resize images to 800x600. Install Pillow for visualization.
- openai/whisper-tiny (Transformers)
  - Task: Automatic speech recognition (transcribe audio to text)
  - Why Fun: Transcribe short audio clips (e.g., movie quotes) in real-time.
  - Pointers: Use pipeline("automatic-speech-recognition"), set fp16, and ensure audio is 16kHz. Install soundfile for audio input.
- stabilityai/stable-diffusion-2-1 (Diffusers)
  - Task: Text-to-image generation (high-quality images)
  - Why Fun: Create surreal or artistic images from creative prompts.
  - Pointers: Use StableDiffusionPipeline, enable fp16, set enable_attention_slicing(), and generate 512x512 images with 20-30 steps.
- CompVis/ldm-super-resolution-4x (Diffusers)
  - Task: Image super-resolution (upscale low-res images)
  - Why Fun: Enhance blurry photos to high resolution for visual demos.
  - Pointers: Load LDMPipeline, use fp16, and input images at 128x128 for 4x upscaling. Install Pillow for image handling.
- facebook/mms-tts-eng (Transformers)
  - Task: Text-to-speech with a different architecture (MMS vs. SpeechT5)
  - Why Fun: Generate speech with unique voice styles for storytelling.
  - Pointers: Use MMSProcessor and MMSForTextToSpeech, set fp16, and move to cuda. Limit text to ~100 characters.
- facebook/audioldm-s-full (Diffusers)
  - Task: Text-to-audio generation (sound effects or ambient sounds)
  - Why Fun: Create soundscapes (e.g., "rainforest at night") for immersive demos.
  - Pointers: Use AudioLDMPipeline, enable fp16, set num_inference_steps=50, and generate 5-10s clips. Install soundfile.
- distilbert-base-uncased-finetuned-sst-2-english (Transformers)
  - Task: Zero-shot text classification (custom labels)
  - Why Fun: Classify text with user-defined labels (e.g., "funny" vs. "serious") for creative analysis.
  - Pointers: Use pipeline("zero-shot-classification"), set fp16, and limit input to ~128 tokens.
- facebook/nougat-base (Transformers)
  - Task: Optical character recognition (OCR) for scanned documents
  - Why Fun: Extract text from images of books or handwritten notes.
  - Pointers: Use NougatProcessor and NougatForConditionalGeneration, preprocess images to 896x672, and use fp16.
- facebook/dino-v2-small (Transformers)
  - Task: Image feature extraction (similarity search or clustering)
  - Why Fun: Compare images for similarity (e.g., group vacation photos) interactively.
  - Pointers: Load Dinov2Model, use fp16, and preprocess images to 224x224. Install scikit-learn for clustering.
- facebook/hubert-base-ls960 (Transformers)
  - Task: Speech emotion recognition (classify emotions in audio)
  - Why Fun: Detect emotions in voice clips for interactive psychology demos.
  - Pointers: Use HubertForSequenceClassification, fine-tuned for emotion, set fp16, and ensure 16kHz audio input.

