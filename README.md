## Languages [TR](#-türkçe) | [EN](#-english)

 ## 🇹🇷 Türkçe

# FPGA Tabanlı Geri Beslemeli Sayısal Aritmetik Birimi

Bu proje, FPGA üzerinde geri beslemeli bir sayısal aritmetik birimi tasarımını içermektedir.  
Tasarlanan devre, aşağıdaki ikinci dereceden fonksiyonu hesaplamak üzere oluşturulmuştur:

**f(x) = y = x² + 4x – 2**

Tasarımda `fp_add` ve `fp_mult` gibi kayan nokta aritmetik bileşenleri (IEEE-754 32-bit) kullanılmıştır.

## Projenin Amacı
Bu projenin amacı, FPGA üzerinde geri beslemeli bir hesaplama yapısı kullanarak
ikinci dereceden polinom fonksiyonlarının hesaplanmasını sağlamaktır.  
Tasarımda kayan nokta çarpanlar ve toplayıcılar kullanılarak fonksiyonun çıktısı
adım adım hesaplanmaktadır.

- **Girdi:** `x` (IEEE-754 32-bit floating-point)  
- **Çıktı:** `y` (IEEE-754 32-bit floating-point)  
- **Fonksiyon:** f(x) = x² + 4x – 2  

## Yapı
- `rtl/fp_add.vhd`: Kayan nokta toplama bileşeni  
- `rtl/fp_mult.vhd`: Kayan nokta çarpma bileşeni  
- `rtl/proje1.vhd`: Üst seviye tasarım (geri beslemeli aritmetik birim)  
- `tb/tb_proje1.vhd`: Testbench dosyası  
- `waves/waves.vcd`: Simülasyon VCD çıktısı  
- `waves/feedback_sim.png`: Simülasyon dalga formu görüntüsü  
- `docs/x^^2+4x-2.png`: Tasarımın blok diyagramı  

## Simülasyon
Simülasyon sonucunda fonksiyonun verilen giriş değerleri için doğru çıktılar ürettiği gözlemlenmiştir.

![Feedback simulation](waves/feedback_sim.png)

## Block Diagram

The following diagram illustrates the quadratic function f(x) = x² + 4x – 2:

![Block diagram](docs/x^^2+4x-2.png)

## Çalıştırma
ModelSim/Questa üzerinde simülasyonu çalıştırmak için:  
```tcl
vsim -do scripts/run_vcd.do
```

Bu komut ile `waves/waves.vcd` dosyası yeniden oluşturulur.  
Var olan sonuçları incelemek için `waves/feedback_sim.png` ve `waves/waves.vcd` dosyaları kullanılabilir.

-------------------------------------------------------------------------------------------------------------------
 ## 🇬🇧 English

# FPGA-Based Feedback Digital Arithmetic Unit

This project implements a feedback digital arithmetic unit on FPGA.  
The designed circuit evaluates the following quadratic function:

**f(x) = y = x² + 4x – 2**

Floating-point arithmetic components (`fp_add`, `fp_mult`) based on IEEE-754 32-bit are used in the design.

## Project Purpose
The purpose of this project is to design a feedback-based computation unit on FPGA
to evaluate quadratic polynomial functions.  
Floating-point multipliers and adders are used to compute the function output step by step.

- **Input:** `x` (IEEE-754 32-bit floating-point)  
- **Output:** `y` (IEEE-754 32-bit floating-point)  
- **Function:** f(x) = x² + 4x – 2  

## Structure
- `rtl/fp_add.vhd`: Floating-point adder component  
- `rtl/fp_mult.vhd`: Floating-point multiplier component  
- `rtl/proje1.vhd`: Top-level design (feedback arithmetic unit)  
- `tb/tb_proje1.vhd`: Testbench file  
- `waves/waves.vcd`: Simulation VCD output  
- `waves/feedback_sim.png`: Simulation waveform screenshot  
- `docs/x^^2+4x-2.png`: Block diagram of the design  

## Simulation
The simulation shows that the circuit produces the correct outputs for the given input values.

![Feedback simulation](waves/feedback_sim.png)

## Block Diagram

The following diagram illustrates the quadratic function f(x) = x² + 4x – 2:

![Block diagram](docs/x^^2+4x-2.png)

## Run
To run the simulation in ModelSim/Questa:  
```tcl
vsim -do scripts/run_vcd.do
```

This command regenerates the waves/waves.vcd file.
To review the existing results, check waves/feedback_sim.png and waves/waves.vcd.
