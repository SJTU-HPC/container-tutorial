import torch

print(torch.__version__)
print(torch.zeros(10,10).cuda().shape)