# Digital Equalization Using Verilog
Verilog project for a 8 Band Audio Equalizer implement on FPGAs

## 1. SPEC
```
Thiết kế bộ cân bằng âm thanh. 
Chi tiết về bộ Equalizer:  Audio equalizer based on FIR filters. | controlpaths.com

Đầu vào: Âm thanh được lấy mẫu với tần số 16Khz, độ rộng bit là 16 bit.
Đầu vào: 8 hệ số khuếch đại cho 8 băng tần số cần cân bằng
Đầu ra: Tín hiệu âm thanh ra. 
Kết quả cần báo cáo:
Độ trễ từ đầu vào đến đầu ra. 
Số cell FPGA cần sử dụng.

1)Cách mô phỏng chứng minh mạch hoạt động đúng
  a. Dùng python đọc file wav, vẽ đồ thị phổ của file wav
  b. Tạo file đầu vào là file text với mỗi hàng là 1 mẫu âm thanh lưu là 1 số HEX 16 bit
  c. Testbench đọc file text âm thanh đầu vào vào mảng bộ nhớ 16bit và đưa vào mạch. 
  d. Testbench lấy đầu ra của mạch và lưu vào file text output.txt mỗi hàng 1 là giá trị mẫu âm thanh 
  e.Dùng python đọc file output.txt và chuyển thành file wav, vẽ đồ thị phổ
  f. Dùng python tạo file outout_python.txt bằng cách dùng các hàm của python để tạo ra bộ Equalizer. So sánh kết quả output.txt với file output_python.txt

2)Tổng hợp mạch bằng FPGA báo cáo các resource cần sử dụng: số cell logic, số LUT, số DSP, số RAM
```
[Audio equalizer based on FIR filters. | controlpaths.com](https://www.controlpaths.com/2021/06/28/audio-equalizer-based-on-fir-filters/)

## 2. File WAV
Trong dự án lần này thì chúng tôi sẽ thực hiện chủ yếu trên file nhạc dưới đây:


https://github.com/Tbthanh/Midterm-Digital_Equalization/assets/90943148/ce053341-9a6d-4a55-820e-a7a66433de0b



### 2.1. Cấu tạo
<img src="Lorem ipsum">

Lorem ipsum

### 2.2. Lorem ipsum
#### 2.2.1. Lorem ipsum
Lorem ipsum

#### 2.2.2. Lorem ipsum
Lorem ipsum

## 3. Lorem ipsum
Lorem ipsum

### 3.1. Lorem ipsum
#### 3.1.1. Lorem ipsum
##### 3.1.1.1. Lorem ipsum
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
