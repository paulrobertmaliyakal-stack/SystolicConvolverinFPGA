import cv2
import binascii

# Step 1: Load image as COLOR, then convert to GRAYSCALE
image_color = cv2.imread('InputImage1.jpg')  # Load as BGR color
gray_image = cv2.cvtColor(image_color, cv2.COLOR_BGR2GRAY)  # Convert to grayscale (1 byte/pixel)

print(f"Original color: {image_color.shape[:2]}")

# Step 2: Resize grayscale image (FPGA-friendly size)
TARGET_WIDTH = 64
TARGET_HEIGHT = 64
resized_gray = cv2.resize(gray_image, (TARGET_WIDTH, TARGET_HEIGHT), interpolation=cv2.INTER_AREA)

print(f"Grayscale resized: {TARGET_WIDTH}x{TARGET_HEIGHT}")

# Step 3: Save resized grayscale image (for visual check)
cv2.imwrite('resized_gray.png', resized_gray)

# Step 4: Convert to bytes (1 byte per pixel = super small!)
pixel_bytes = resized_gray.tobytes()
print(f"Total bytes: {len(pixel_bytes)}")  # 64*64 = 4096 bytes!

# Step 5: Convert to hex string
hex_string = binascii.hexlify(pixel_bytes).decode('utf-8')

# Step 6: Format for Vivado - ONE PIXEL PER LINE (2 hex chars = 1 byte)
formatted_hex = '\n'.join([hex_string[i:i+2] for i in range(0, len(hex_string), 2)])

# Step 7: Save hex file
with open(r'C:\Users\PAUL\Documents\ImageProcessingInter\InputImage1.hex', 'w') as f:
    f.write(formatted_hex)

print("✅ 'InputImage1.hex' ready for Vivado! (1 pixel per line)")
print("First 8 pixels:")
print(formatted_hex.split('\n')[:8])
