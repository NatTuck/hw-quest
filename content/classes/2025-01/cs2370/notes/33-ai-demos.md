---
title: "cs2370 Notes: 33 AI Demos"
date: "2025-04-15"
---

(Thanks to Grok for some suggestions. Let's see
if any of it's sample code works.)

More text generation (distilgpt2):

```python
from transformers import pipeline
import torch

generator = pipeline("text-generation", 
                     model="distilgpt2", device=0)

# Generate text
prompt = "In a futuristic city, AI robots and humans coexist. The story begins when..."
output = generator(prompt, max_length=100, num_return_sequences=1)
print(output[0]["generated_text"])
```

Image classification:

```python
from transformers import pipeline
from PIL import Image
import requests
from io import BytesIO

classifier = pipeline("image-classification", model="google/vit-base-patch16-224", device=0)

url = "https://huggingface.co/datasets/Narsil/image_dummy/raw/main/parrots.png"
response = requests.get(url)
image = Image.open(BytesIO(response.content))

results = classifier(image)
for result in results[:3]:
    print(f"Label: {result['label']}, Score: {result['score']:.4f}")
```

Image Generation:

```python
from diffusers import AutoPipelineForText2Image
import torch

pipeline = AutoPipelineForText2Image.from_pretrained(
    "runwayml/stable-diffusion-v1-5",
    torch_dtype=torch.float16,
    use_safetensors=True
).to("cuda")

# Generate image
prompt = "A futuristic cityscape at sunset, cyberpunk style"
image = pipeline(prompt, num_inference_steps=30, guidance_scale=7.5).images[0]

# Display and save image
image
```

Text to speech:

```python
# Import libraries
from transformers import SpeechT5Processor, SpeechT5ForTextToSpeech, SpeechT5HifiGan
import torch
import soundfile as sf
from IPython.display import Audio

# Load model and processor
processor = SpeechT5Processor.from_pretrained("microsoft/speecht5_tts")
model = SpeechT5ForTextToSpeech.from_pretrained("microsoft/speecht5_tts").to("cuda")
vocoder = SpeechT5HifiGan.from_pretrained("microsoft/speecht5_hifigan").to("cuda")

# Input text
text = "Hello! This is a text-to-speech demo using SpeechT5 on an NVIDIA RTX 3060."

# Process text
inputs = processor(text=text, return_tensors="pt").to("cuda")

# Generate speech
speaker_embeddings = torch.zeros(1, 512).to("cuda")  # Default speaker embedding
speech = model.generate_speech(inputs["input_ids"], speaker_embeddings, vocoder=vocoder)

# Save and play audio
sf.write("speecht5_output.wav", speech.cpu().numpy(), samplerate=16000)
Audio("speecht5_output.wav")
```


Another one:

```python
# Import libraries
from transformers import AutoProcessor, BarkModel
import torch
import soundfile as sf
from IPython.display import Audio

# Load model and processor
processor = AutoProcessor.from_pretrained("suno/bark-small")
model = BarkModel.from_pretrained("suno/bark-small", torch_dtype=torch.float16).to("cuda")

# Input text
text = "In a galaxy far, far away, AI models create stunning audio experiences."

# Process text
inputs = processor(text, voice_preset="v2/en_speaker_6", return_tensors="pt").to("cuda")

# Generate speech
with torch.no_grad():
    audio = model.generate(**inputs).cpu().numpy()

# Save and play audio
sf.write("bark_output.wav", audio, samplerate=model.config.sampling_rate)
Audio("bark_output.wav")
```

Song generation?

```python
# Install dependencies
# $ pip install audiocraft torch soundfile numpy

# Import libraries
from audiocraft.models import MusicGen
import torch
import soundfile as sf
from IPython.display import Audio

# Load MusicGen small model with mixed precision
model = MusicGen.get_pretrained('facebook/musicgen-small')
model.set_generation_params(duration=10)  # Generate 10-second clip
model.lm.to(dtype=torch.float16, device='cuda')  # Use fp16 on GPU

# Input text prompt
prompt = "A catchy pop instrumental with upbeat drums and electric guitar"

# Generate music
wav = model.generate([prompt], progress=True)[0].cpu().numpy()

# Save and play audio
sf.write("musicgen_output.wav", wav, model.sample_rate)
Audio("musicgen_output.wav")
```

Animation

```python
# Install dependencies
# $ pip install diffusers transformers torch imageio pillow accelerate

# Import libraries
from diffusers import AnimateDiffPipeline, MotionAdapter
from diffusers.utils import export_to_gif
import torch
from IPython.display import Image as IPythonImage

# Load motion adapter and Stable Diffusion model
adapter = MotionAdapter.from_pretrained("guoyww/animatediff-motion-adapter-v1-5-2", torch_dtype=torch.float16)
pipe = AnimateDiffPipeline.from_pretrained(
    "runwayml/stable-diffusion-v1-5",
    motion_adapter=adapter,
    torch_dtype=torch.float16,
    use_safetensors=True
).to("cuda")
pipe.enable_model_cpu_offload()  # Optimize for RTX 3060

# Input text prompt
prompt = "A cartoon robot dancing in a futuristic city, vibrant colors"

# Generate video frames
output = pipe(
    prompt,
    num_frames=16,  # Short clip for GIF
    guidance_scale=7.5,
    num_inference_steps=25
)
frames = output.frames[0]

# Export to animated GIF
export_to_gif(frames, "animated_robot.gif")

# Display GIF in Jupyter
IPythonImage(filename="animated_robot.gif")
```
