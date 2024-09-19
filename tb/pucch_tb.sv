`timescale 1ns / 1ps

`define TEST_F0
// `define TEST_F1

/* PUCCH0
  PUCCH0 alpha * n + r = ( 0 *  0 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  1 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  2 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  3 +  3) mod 24 =  3. (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  4 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  5 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  6 + 21) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  7 +  3) mod 24 =  3. (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  8 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  9 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 * 10 +  9) mod 24 =  9. (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 * 11 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  0 + 15) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  1 +  9) mod 24 = 13. (-0.9659 + -0.2588i)       -0.9659 - 0.2588i
  PUCCH0 alpha * n + r = ( 4 *  2 +  9) mod 24 = 17. (-0.2588 + -0.9659i)       -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  3 +  3) mod 24 = 15. (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  4 + 15) mod 24 =  7. (-0.2588 + 00.9659i)       -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  5 +  9) mod 24 =  5. (00.2588 + 00.9659i)        0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  6 + 21) mod 24 = 21. (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  7 +  3) mod 24 =  7. (-0.2588 + 00.9659i)       -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  8 +  9) mod 24 = 17. (-0.2588 + -0.9659i)       -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  9 + 15) mod 24 =  3. (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 4 * 10 +  9) mod 24 =  1. (00.9659 + 00.2588i)        0.9659 + 0.2588i
  PUCCH0 alpha * n + r = ( 4 * 11 + 15) mod 24 = 11. (-0.9659 + 00.2588i)       -0.9659 + 0.2588i

  PUCCH 0. [symStart nPUCCHSym] = [ 4  2]
  ack = 3 (2 bit), sr = 1 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 1
  mcs = 7
*/

/* PUCCH1
  |TESTBENCH  | y(n)  | wi(m)y(n) |

  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  0 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        -0.0000 + 1.0000i         -0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  1 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).        -0.8660 - 0.5000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  2 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).         0.5000 + 0.8660i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  3 +  3) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).        -1.0000 + 0.0000i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  4 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).        -0.8660 - 0.5000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  5 +  9) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).         0.8660 - 0.5000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  6 + 21) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).         1.0000 - 0.0000i          1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  7 +  3) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).         0.5000 - 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  8 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).        -0.5000 - 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  9 + 15) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).        -1.0000 - 0.0000i         -1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 * 10 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).         0.5000 - 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 * 11 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).        -0.5000 - 0.8660i         -0.5000 - 0.8660i

  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  0 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).        -0.0000 + 1.0000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  1 +  9) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).         0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  2 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).         0.5000 - 0.8660i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  3 +  3) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        -1.0000 + 0.0000i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  4 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).         0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  5 +  9) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        -0.8660 - 0.5000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  6 + 21) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).         1.0000 - 0.0000i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  7 +  3) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).         0.5000 + 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  8 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).        -0.5000 + 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  9 + 15) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        -1.0000 + 0.0000i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 * 10 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).         0.5000 + 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 * 11 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).        -0.5000 + 0.8660i         -0.5000 - 0.8660i

  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  0 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        -0.0000 + 1.0000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  1 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).         0.5000 - 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  2 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).        -0.5000 - 0.8660i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  3 +  3) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).         0.0000 + 1.0000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  4 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        -0.8660 - 0.5000i         -0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  5 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).         0.5000 + 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  6 + 21) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        -1.0000 + 0.0000i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  7 +  3) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        -0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  8 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).        -0.5000 - 0.8660i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  9 + 15) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).         0.0000 - 1.0000i         -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 * 10 +  9) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        -0.5000 + 0.8660i          1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 * 11 + 15) mod 24 =  2/24 cyc. (00.8660 + 00.5000i).        -0.8660 + 0.5000i          0.8660 + 0.5000i

  PUCCH 1. [symStart nPUCCHSym] = [ 4  7]
  ack = 1 (1 bit), sr = 0 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 1
  mcs = 0

  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  0 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).       -0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  1 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  2 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  3 +  3) mod 24 = 18/24 cyc. (00.0000 + -1.0000i).       -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  4 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).       -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  5 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  6 + 21) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).       -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  7 +  3) mod 24 =  2/24 cyc. (00.8660 + 00.5000i).        0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  8 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 *  9 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 * 10 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 +  8 * 11 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  0 + 15) mod 24 =  2/24 cyc. (00.8660 + 00.5000i).        0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  1 +  9) mod 24 = 18/24 cyc. (00.0000 + -1.0000i).       -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  2 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  3 +  3) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  4 + 15) mod 24 = 18/24 cyc. (00.0000 + -1.0000i).       -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  5 +  9) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  6 + 21) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  7 +  3) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  8 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 *  9 + 15) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 * 10 +  9) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (20 + 15 + 22 * 11 + 15) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  0 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  1 +  9) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  2 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  3 +  3) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  4 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i).        0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  5 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).       -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  6 + 21) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  7 +  3) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).       -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  8 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 *  9 + 15) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 * 10 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).       -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 14 * 11 + 15) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  0 + 15) mod 24 = 18/24 cyc. (00.0000 + -1.0000i).       -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  1 +  9) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  2 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i).       -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  3 +  3) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  4 + 15) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  5 +  9) mod 24 =  2/24 cyc. (00.8660 + 00.5000i).        0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  6 + 21) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).       -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  7 +  3) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  8 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 *  9 + 15) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 * 10 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (12 + 15 + 22 * 11 + 15) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  0 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).       -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  1 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  2 +  9) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  3 +  3) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i).       -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  4 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  5 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i).       -1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  6 + 21) mod 24 = 20/24 cyc. (00.5000 + -0.8660i).        0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  7 +  3) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  8 +  9) mod 24 =  0/24 cyc. (01.0000 + 00.0000i).        1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 *  9 + 15) mod 24 =  2/24 cyc. (00.8660 + 00.5000i).        0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 * 10 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 20 * 11 + 15) mod 24 = 18/24 cyc. (00.0000 + -1.0000i).        0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  0 + 15) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  1 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  2 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  3 +  3) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  4 + 15) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  5 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  6 + 21) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i).       -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  7 +  3) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i).       -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  8 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 *  9 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 * 10 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i).        0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 4 + 15 + 12 * 11 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i).        0.8660 - 0.5000i

  PUCCH 1. [symStart nPUCCHSym] = [ 0 12]
  ack = 1 (1 bit), sr = 0 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 5
  mcs = 0
*/

/* PUCCH2
  PUCCH2 nid = 512, rnti = 56789, cinit = 1860862464
  PUCCH2. d = QPSK(b(x) ^ c(x)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071, -0.7071)     -0.707106781186548 - 0.707106781186548i
  PUCCH2. d = QPSK(b(x) ^ c(x)) = QPSK(01 ^ 11) = 21/24 cyc (00.7071, -0.7071)      0.707106781186548 - 0.707106781186548i
  PUCCH2. d = QPSK(b(x) ^ c(x)) = QPSK(11 ^ 10) =  9/24 cyc (-0.7071, 00.7071)     -0.707106781186548 + 0.707106781186548i
  PUCCH2. d = QPSK(b(x) ^ c(x)) = QPSK(11 ^ 10) =  9/24 cyc (-0.7071, 00.7071)     -0.707106781186548 + 0.707106781186548i
*/

/* PUCCH3
  Testbench modulation points | Matlab modulation points  | Matlab fft(12 points) | Matlab fft(12 points)/sqrt(Msc)

  PUCCH3 nid = 512, rnti = 56789, cinit = 1860862464
  PUCCH3. d = QPSK(b( 0) ^ c( 0)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i        0.000000000000000 - 1.414213562373095i        0.000000000000000 - 0.408248290463863i
  PUCCH3. d = QPSK(b( 1) ^ c( 1)) = QPSK(01 ^ 11) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i       -1.086044163149559 + 4.053171996137779i       -0.313513944973110 + 1.170049971521000i
  PUCCH3. d = QPSK(b( 2) ^ c( 2)) = QPSK(11 ^ 10) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        0.189468690981506 - 3.156596523969726i        0.054694899870589 - 0.911230926418479i
  PUCCH3. d = QPSK(b( 3) ^ c( 3)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i       -2.828427124746190 - 1.414213562373095i       -0.816496580927726 - 0.408248290463863i
  PUCCH3. d = QPSK(b( 4) ^ c( 4)) = QPSK(01 ^ 00) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        1.224744871391589 - 3.535533905932738i        0.353553390593274 - 1.020620726159658i
  PUCCH3. d = QPSK(b( 5) ^ c( 5)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i       -5.985023648715917 + 1.603682253354601i       -1.727727507346206 + 0.462943190334452i
  PUCCH3. d = QPSK(b( 6) ^ c( 6)) = QPSK(10 ^ 00) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i       -2.828427124746190 + 1.414213562373095i       -0.816496580927726 + 0.408248290463863i
  PUCCH3. d = QPSK(b( 7) ^ c( 7)) = QPSK(01 ^ 01) =  3/24 cyc (00.7071 + 00.7071i)        0.707106781186548 + 0.707106781186548i       -0.707106781186548 - 0.189468690981506i       -0.204124145231932 - 0.054694899870589i
  PUCCH3. d = QPSK(b( 8) ^ c( 8)) = QPSK(01 ^ 11) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i       -1.224744871391589 - 3.535533905932738i       -0.353553390593274 - 1.020620726159658i
  PUCCH3. d = QPSK(b( 9) ^ c( 9)) = QPSK(10 ^ 00) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i        2.828427124746190 - 1.414213562373095i        0.816496580927726 - 0.408248290463863i
  PUCCH3. d = QPSK(b(10) ^ c(10)) = QPSK(01 ^ 00) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        2.638958433764684 + 1.742382961596631i        0.761801681057137 + 0.502982635954616i
  PUCCH3. d = QPSK(b(11) ^ c(11)) = QPSK(01 ^ 01) =  3/24 cyc (00.7071 + 00.7071i)        0.707106781186548 + 0.707106781186548i       -0.707106781186548 - 2.638958433764684i       -0.204124145231932 - 0.761801681057137i
  PUCCH3. d = QPSK(b(12) ^ c(12)) = QPSK(00 ^ 10) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i       -2.828427124746190 + 1.414213562373095i       -0.816496580927726 + 0.408248290463863i
  PUCCH3. d = QPSK(b(13) ^ c(13)) = QPSK(01 ^ 00) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        1.931851652578137 - 1.931851652578137i        0.557677535825205 - 0.557677535825205i
  PUCCH3. d = QPSK(b(14) ^ c(14)) = QPSK(10 ^ 10) =  3/24 cyc (00.7071 + 00.7071i)        0.707106781186548 + 0.707106781186548i        5.277916867529369 + 0.000000000000000i        1.523603362114274 + 0.000000000000000i
  PUCCH3. d = QPSK(b(15) ^ c(15)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i       -1.414213562373095 + 0.000000000000000i       -0.408248290463863 + 0.000000000000000i
  PUCCH3. d = QPSK(b(16) ^ c(16)) = QPSK(10 ^ 11) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        3.863703305156274 - 0.378937381963012i        1.115355071650411 - 0.109389799741179i
  PUCCH3. d = QPSK(b(17) ^ c(17)) = QPSK(01 ^ 10) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i       -0.517638090205042 + 0.517638090205042i       -0.149429245361342 + 0.149429245361342i
  PUCCH3. d = QPSK(b(18) ^ c(18)) = QPSK(11 ^ 11) =  3/24 cyc (00.7071 + 00.7071i)        0.707106781186548 + 0.707106781186548i        2.828427124746190 + 4.242640687119286i        0.816496580927726 + 1.224744871391589i
  PUCCH3. d = QPSK(b(19) ^ c(19)) = QPSK(10 ^ 11) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i       -0.517638090205042 - 3.346065214951232i       -0.149429245361342 - 0.965925826289068i
  PUCCH3. d = QPSK(b(20) ^ c(20)) = QPSK(11 ^ 10) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i       -1.035276180410083 - 5.277916867529369i       -0.298858490722684 - 1.523603362114274i
  PUCCH3. d = QPSK(b(21) ^ c(21)) = QPSK(10 ^ 01) = 15/24 cyc (-0.7071 + -0.7071i)       -0.707106781186548 - 0.707106781186548i       -1.414213562373095 - 2.828427124746191i       -0.408248290463863 - 0.816496580927726i
  PUCCH3. d = QPSK(b(22) ^ c(22)) = QPSK(10 ^ 11) =  9/24 cyc (-0.7071 + 00.7071i)       -0.707106781186548 + 0.707106781186548i        0.378937381963012 + 0.000000000000000i        0.109389799741179 + 0.000000000000000i
  PUCCH3. d = QPSK(b(23) ^ c(23)) = QPSK(10 ^ 00) = 21/24 cyc (00.7071 + -0.7071i)        0.707106781186548 - 0.707106781186548i        1.931851652578137 - 0.896575472168054i        0.557677535825205 - 0.258819045102521i
*/

// PUCCH 0 get nPUCCHSym(1-2) of alpha(s), starting from symStart(0-10)

module pucch_tb;

  // Parameters

  localparam nSlotSymb = 14;  //! (cyclic prefix (cp) == 'extended') ? 12 : 14
  localparam nRBSC = 12;

`ifdef TEST_F0
  /*
    PUCCH 0. [symStart nPUCCHSym] = [ 4  2]
    ack = 3 (2 bit), sr = 1 (1 bit)
    m0, nslot, nid = 5, 3, 512
    occi = 0
    mcs = 7
  */
  localparam VCD_FILE = "vcds/pucch0_tb.vcd";

  localparam test_pucch_format = 0;

  localparam test_symStart = 4;
  localparam test_nPUCCHSym = 2;  // nPUCCHSym = 7 => nSF = floor(nPUCCHSym/2) = 3

  localparam test_ack = 2'b11;  // ack = [bit1; bit0]
  localparam test_lenACK = 2;
  localparam test_sr = 1;
  localparam test_lenSR = 1;

  localparam test_m0 = 5;  // initialCS
  // localparam test_nslot = 3;
  localparam test_nslot = 0;
  localparam test_nid = 512;
`endif

`ifdef TEST_F1
  /*
    PUCCH 1. [symStart nPUCCHSym] = [ 4  7]
    ack = 1 (1 bit), sr = 0 (1 bit)
    m0, nslot, nid = 5, 3, 512
    occi = 1
    mcs = 0
  */
  localparam VCD_FILE = "vcds/pucch1_tb.vcd";

  localparam test_pucch_format = 1;

  localparam test_symStart = 4;
  localparam test_nPUCCHSym = 7;  // nPUCCHSym = 7 => nSF = floor(nPUCCHSym/2) = 3

  localparam test_ack = 2'b01;  // ack = [bit1; bit0]
  localparam test_lenACK = 1;
  localparam test_sr = 0;
  localparam test_lenSR = 1;

  localparam test_m0 = 5;  // initialCS
  localparam test_nslot = 3;
  localparam test_nid = 512;

  localparam test_occi = 1;
`endif


  localparam test_rnti = 56789;  // F2 F3

  localparam test_Mrb = 2;  // F3
  localparam test_pi2bpsk_qpsk = 0;  // 1: pi/2 BPSK, 0: QPSK

  initial begin
    begin
      $dumpfile(VCD_FILE);
      $dumpvars(10, pucch_dut);
      reset(3);

`ifdef TEST_F0
      test_f0f1(test_pucch_format,  //
                test_symStart, test_nPUCCHSym,  //
                test_ack, test_lenACK, test_sr, test_lenSR,  //
                test_m0, test_nslot, test_nid,  //
                0);
      nop_clk(10);
`endif
`ifdef TEST_F1
      test_f0f1(test_pucch_format,  //
                test_symStart, test_nPUCCHSym,  //
                test_ack, test_lenACK, test_sr, test_lenSR,  //
                test_m0, test_nslot, test_nid,  //
                test_occi);
      nop_clk(10);
`endif

      // test_f2(test_nid, test_rnti, 4);
      // nop_clk(10);

      test_f3(test_nid, test_rnti, test_Mrb, 1 * (test_Mrb * nRBSC), test_pi2bpsk_qpsk);  //! The number of 2-bit value must be an integer multiple of (allocated number of subcarriers Msc = Mrb * nRBSC)
      nop_clk(10);

      // test_f0f1(test_pucch_format,  //
      //      test_symStart, test_nPUCCHSym,  //
      //      test_ack, test_lenACK, test_sr, test_lenSR,  //
      //      test_m0, test_nslot, test_nid,  //
      //      test_occi);
      // nop_clk(10);

      $finish;
    end
  end

  integer count_pucch2 = 0;
  integer count_pucch3 = 0;
  always @(posedge clk) begin
    if (o_valid) begin
      case (i_pucch_format)
        0: begin
          $write("PUCCH0 alpha * n + r = (%2d * %2d + %2d) mod 24 = %2d/24 cyc. (%07.4f + %07.4fi). ",  //
                 pucch_dut.alpha_cyc_24, pucch_dut.base_seq_n, pucch_dut.base_seq_cyc_24, pucch_dut.point_cyc_24,  //
                 to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
          $display();
        end
        1: begin
          $write("PUCCH1 z = w + d + alpha * n + r = (%2d + %2d + %2d * %2d + %2d) mod 24 = %2d/24 cyc. (%07.4f + %07.4fi). ",  //
                 pucch_dut.spread_wi_phi_cyc_24, pucch_dut.cyc_24_modulation, pucch_dut.alpha_cyc_24, pucch_dut.base_seq_n, pucch_dut.base_seq_cyc_24, pucch_dut.point_cyc_24,  //
                 to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
          $display("wi_phi = %2d/24 cyc (is supported = %1b)", pucch_dut.spread_wi_phi_cyc_24, pucch_dut.spread_is_supported);
        end
        2: begin
          count_pucch2 <= count_pucch2 + 1;
          $write("PUCCH2. d = QPSK(b(%2d) ^ c(%2d)) = QPSK(%2b ^ %2b)",  //
                 count_pucch2, count_pucch2, pucch_dut.uciCW, pucch_dut.scramble_f2_bit);
          $write(" = %2d/24 cyc (%07.4f + %07.4fi)",  //
                 pucch_dut.d_qpsk, to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
          $display();
        end
        3: begin
          count_pucch3 <= count_pucch3 + 1;
          $write("PUCCH3. d = QPSK(b(%2d) ^ c(%2d)) = QPSK(%2b ^ %2b)",  //
                 count_pucch3, count_pucch3, pucch_dut.uciCW, pucch_dut.scramble_f2_bit);
          $write(" = %2d/24 cyc (%07.4f + %07.4fi)",  //
                 pucch_dut.d_qpsk, to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
          $display();
        end
        default: begin

        end
      endcase
    end
    if (o_done) begin
      nop_clk(10);
      $finish;
    end
  end

  reg [1:0] test_uciCW[0:23];
  integer test_uciCW_index;
  initial $readmemb("tb/pucch/uciCW.txt", test_uciCW);

  task automatic test_f3;
    input integer nid;
    input integer rnti;
    input integer Mrb;
    input integer get;
    input pi2bpsk_qpsk;
    integer uciCW;
    begin
      @(negedge clk);
      i_pucch_format   = 3;
      i_nid            = nid;
      i_rnti           = rnti;
      i_Mrb            = Mrb;
      i_pi2bpsk_qpsk   = pi2bpsk_qpsk;

      test_uciCW_index = 0;

      i_start          = 1;
      @(negedge clk);
      i_start = 0;

      $display("PUCCH3 nid = %1d, rnti = %1d, cinit = %1d", nid, rnti, pucch_dut.scramble_f2_init);

      // @(posedge clk);
      i_uciCW_valid = 1;
      repeat (get) begin
        uciCW = $urandom();
        @(negedge clk);
        i_uciCW = test_uciCW[test_uciCW_index];
        test_uciCW_index = test_uciCW_index + 1;
      end
      i_uciCW_valid = 0;
    end
  endtask  //automatic

  task automatic test_f2;
    input integer nid;
    input integer rnti;
    input integer get;
    integer uciCW;
    begin
      @(negedge clk);
      i_pucch_format   = 2;
      i_nid            = nid;
      i_rnti           = rnti;

      test_uciCW_index = 0;

      i_start          = 1;
      @(negedge clk);
      i_start = 0;

      $display("PUCCH2 nid = %1d, rnti = %1d, cinit = %1d", nid, rnti, pucch_dut.scramble_f2_init);

      repeat (get) begin
        // uciCW   = $urandom();
        // @(negedge clk);

        i_uciCW_valid = 1;
        @(negedge clk);
        i_uciCW_valid = 0;
        i_uciCW = test_uciCW[test_uciCW_index];
        test_uciCW_index = test_uciCW_index + 1;
      end
    end
  endtask  //automatic

  task automatic test_f0f1;
    input integer pucch_format;
    input integer symStart, nPUCCHSym;
    input integer ack, lenACK, sr, lenSR;
    input integer m0, nslot, nid;
    input integer occi;
    begin
      // @(negedge clk);
      i_pucch_format = pucch_format;
      i_symStart     = symStart;
      i_nPUCCHSym    = nPUCCHSym;
      i_ack          = ack;
      i_lenACK       = lenACK;
      i_sr           = sr;
      i_lenSR        = lenSR;
      i_m0           = m0;
      //   i_mcs          = mcs;
      i_nslot        = nslot;
      i_nid          = nid;
      i_occi         = occi;

      @(posedge clk);
      i_start = 1;
      @(posedge clk);
      i_start = 0;

      @(posedge o_done);
      $display();
      $display("PUCCH %1d. [symStart nPUCCHSym] = [%2d %2d]", pucch_format, symStart, nPUCCHSym);
      $display("ack = %1d (%1d bit), sr = %1d (%1d bit)", ack, lenACK, sr, lenSR);
      $display("m0, nslot, nid = %1d, %1d, %1d", m0, nslot, nid);
      $display("occi = %1d", occi);
      $display("mcs = %1d", pucch_dut.mcs);
    end
  endtask  //automatic

  // Ports
  reg         clk = 0;
  reg         rst = 0;
  reg  [ 2:0] i_pucch_format;
  reg         i_start = 0;
  reg  [ 3:0] i_symStart;
  reg  [ 3:0] i_nPUCCHSym;
  reg  [ 1:0] i_ack;
  reg  [ 1:0] i_lenACK;
  reg         i_sr;
  reg         i_lenSR;
  reg  [ 3:0] i_m0;
  //   reg [3:0] i_mcs;
  reg  [ 7:0] i_nslot;
  reg  [ 9:0] i_nid;
  reg  [ 2:0] i_occi;

  reg  [15:0] i_rnti;  //! [Format 2] Radio Network Temporary Identifier (0-65535)
  reg  [ 1:0] i_uciCW;  //! [Format 2] Encoded UCI codeword as per TS 38.212 Section 6.3.1
  reg         i_uciCW_valid;  //! [Format 2] uciCW is valid and ready to continue generate PUCCH sequence

  reg  [ 4:0] i_Mrb;
  reg         i_pi2bpsk_qpsk;

  wire [15:0] o_pucch_re;
  wire [15:0] o_pucch_im;
  wire        o_valid;
  wire        o_done;
  //

  pucch pucch_dut (
      .clk(clk),
      .rst(rst),

      .i_pucch_format(i_pucch_format),

      .i_start(i_start),

      .i_symStart (i_symStart),
      .i_nPUCCHSym(i_nPUCCHSym),

      .i_ack   (i_ack),
      .i_lenACK(i_lenACK),
      .i_sr    (i_sr),
      .i_lenSR (i_lenSR),

      .i_m0   (i_m0),
      //   .i_mcs  (i_mcs),
      .i_nslot(i_nslot),
      .i_nid  (i_nid),

      .i_occi(i_occi),

      .i_rnti       (i_rnti),
      .i_uciCW      (i_uciCW),
      .i_uciCW_valid(i_uciCW_valid),

      .i_Mrb(i_Mrb),
      .i_pi2bpsk_qpsk(i_pi2bpsk_qpsk),

      .o_pucch_re(o_pucch_re),
      .o_pucch_im(o_pucch_im),
      .o_valid   (o_valid),
      .o_done    (o_done)
  );

  task automatic reset;
    input integer clks;
    begin
      rst = 1;
      repeat (clks) @(posedge clk);
      rst = 0;
    end
  endtask  //automatic

  task automatic nop_clk;
    input integer clks;
    begin
      repeat (clks) @(posedge clk);
    end
  endtask  //automatic

  localparam CLK_PERIOD = 10;
  always #(CLK_PERIOD / 2) clk <= !clk;

  integer clk_count = 0;
  localparam MAX_CLK = 500;

  always @(posedge clk) begin
    clk_count <= clk_count + 1;
    if (clk_count > MAX_CLK) begin
      $display("MAX CLK");
      $finish;
    end
  end

  function real to_real;
    input signed [15:0] i_int;
    begin
      to_real = i_int;
    end
  endfunction

endmodule
