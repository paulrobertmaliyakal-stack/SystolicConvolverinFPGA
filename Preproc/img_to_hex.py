from PIL import Image
import sys

# Usage: python img_to_hex.py my_photo.jpg

INPUT_IMAGE = r"C:\Users\Hirthick\Desktop\Preprocessing\lotus.jpg" 
OUTPUT_HEX  = r"C:\Users\Hirthick\Desktop\Preprocessing\image.hex"
WIDTH       = 1280
HEIGHT      = 720

def main():
    try:
        img = Image.open(INPUT_IMAGE)
        img = img.resize((WIDTH, HEIGHT))
        img = img.convert('RGB')
        
        pixels = list(img.getdata())
        
        with open(OUTPUT_HEX, 'w') as f:
            for r, g, b in pixels:
                f.write(f"{r:02X}{g:02X}{b:02X}\n")
                
        print(f"Done. {OUTPUT_HEX} generated with {len(pixels)} pixels.")
        
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()