
## CUDA Install Steps

### As the admin user:

```bash
sudo apt update -y && sudo apt upgrade -y
```

Install CUDA and drivers from Nvidia.

(specifically, the proprietary ```cuda-drivers``` packge)

https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network

(Installing external drivers on Linux is a bad idea. This
is one of the issues with Nvidia hardware.)

Once the Nvidia repo is installed we can install well-supported CUDA with
```sudo apt install cuda-12-4```


### As the Intro user

Then the Pytorch directions should work.

As of 04/2025, the default Pytorch is for Cuda 12.4,
so 

```
conda activate
pip install torch torchvision torchaudio accelerate
```



