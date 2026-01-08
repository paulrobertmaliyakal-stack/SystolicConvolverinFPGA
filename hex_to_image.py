import numpy as np
from PIL import Image
import re

# Step 1: Read hex file (1 pixel per line format)
def hex_to_image(hex_file_path, width=64, height=64, output_path='output_image.png'):
    with open(hex_file_path, 'r') as f:
        hex_data = f.read()
    
    # Extract all hex values (handles both 1-per-line and multi-per-line)
    hex_values = re.findall(r'[0-9a-fA-F]{2}', hex_data)
    print(f"Found {len(hex_values)} hex values")
    
    # Verify we have exactly 4096 pixels
    if len(hex_values) != width * height:
        print(f"Warning: Expected {width*height} pixels, got {len(hex_values)}")
    
    # Convert hex strings to bytes
    byte_data = bytes.fromhex(' '.join(hex_values[:width*height]))
    
    # Reshape to 2D image array (64x64)
    image_array = np.frombuffer(byte_data, dtype=np.uint8).reshape((height, width))
    
    # Convert to PIL Image and save
    image = Image.fromarray(image_array, mode='L')  # 'L' = grayscale
    image.save(output_path)
    image.show()  # Opens image viewer
    
    print(f"✅ Image saved: {output_path}")
    print(f"Size: {width}x{height} = {width*height} pixels")
    return image

# Usage - Replace with your hex file path
hex_to_image(r'D:\internship\firstvivadoproj\EyeRissFinal\EyeRissFinal.sim\sim_1\behav\xsim\output.hex', 
             width=62, height=62, output_path='reconstructed_image.png')