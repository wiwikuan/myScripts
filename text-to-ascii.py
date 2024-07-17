#!/usr/bin/env python3

# 輸入文字，利用 BoutiqueBitmap9x9_1.9.ttf 點陣字體輸出成 ASCII ART
#
#

from PIL import Image, ImageFont, ImageDraw

def text_to_terminal(font_path, text, height=9, spacing=1):
    # Load the font with the specified height
    font = ImageFont.truetype(font_path, height-1)
    
    # Calculate the width of the text with additional spacing
    width = int(font.getlength(text) + spacing * len(text))
    
    # Create an image with 'L' mode (8-bit pixels, black and white)
    image = Image.new('L', (width, height), 1)
    draw = ImageDraw.Draw(image)
    
    # Draw the text with added space after each character
    current_x = 0
    for char in text:
        draw.text((current_x, 0), char, font=font, fill=255)
        current_x += font.getlength(char) + spacing
    
    # Convert the image to grayscale and threshold to binary
    binary_image = image.point(lambda x: 0 if x < 128 else 1, '1')
    
    # Convert to ASCII
    ascii_art = []
    for y in range(binary_image.height):
        line = []
        for x in range(binary_image.width):
            pixel = binary_image.getpixel((x, y))
            line.append('█' if pixel else ' ')
        ascii_art.append(''.join(line))
    
    return '\n'.join(ascii_art)

def main():
    font_path = '~/BoutiqueBitmap9x9_1.9.ttf'  # Path to your TrueType font file
    height = 11  # Desired height of the text in pixels
    spacing = 0  # Space between characters

    print("歡迎使用文字轉ASCII藝術工具！")
    print("請輸入您想轉換的文字（輸入'q'退出）：")

    while True:
        user_input = input("> ")
        if user_input.lower() == 'q':
            print("感謝使用，再見！")
            break

        # Generate and display the ASCII art
        ascii_art = text_to_terminal(font_path, user_input, height, spacing)
        print("\n您的ASCII藝術：")
        print(ascii_art)
        print("\n請輸入下一段文字（或輸入'q'退出）：")

if __name__ == "__main__":
    main()
