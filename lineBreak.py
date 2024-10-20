import argparse

def format_chinese_text(text):
    # 定義需要換行的中文標點符號
    punctuations = ['，', '。', '！', '？', '；', '：', '…', '、']
    
    formatted_text = ""
    for char in text:
        formatted_text += char
        if char in punctuations:
            formatted_text += '\n'
    
    return formatted_text

def process_file(input_file, output_file):
    try:
        with open(input_file, 'r', encoding='utf-8') as infile:
            text = infile.read()
        
        formatted_text = format_chinese_text(text)
        
        with open(output_file, 'w', encoding='utf-8') as outfile:
            outfile.write(formatted_text)
        
        print(f"處理完成。格式化後的文本已保存到 {output_file}")
    except IOError as e:
        print(f"文件處理錯誤：{str(e)}")

def main():
    parser = argparse.ArgumentParser(description='格式化中文文本，在指定的標點符號後添加換行。')
    parser.add_argument('input', help='輸入文件的路徑')
    parser.add_argument('output', help='輸出文件的路徑')
    
    args = parser.parse_args()
    
    process_file(args.input, args.output)

if __name__ == "__main__":
    main()
