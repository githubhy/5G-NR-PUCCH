`timescale 1ns / 1ps

// `define TEST_F0
// `define TEST_F1
// `define TEST_F2
`define TEST_F3
// `define TEST_F4

/* PUCCH0
  PUCCH0 alpha * n + r = ( 0 *  0 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  1 +  9) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  2 +  9) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  3 +  3) mod 24 =  3/24 cyc. (00.7071 + 00.7071i).        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  4 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  5 +  9) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  6 + 21) mod 24 = 21/24 cyc. (00.7071 + -0.7071i).        0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  7 +  3) mod 24 =  3/24 cyc. (00.7071 + 00.7071i).        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  8 +  9) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 *  9 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 0 * 10 +  9) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).       -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 0 * 11 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  0 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  1 +  9) mod 24 = 13/24 cyc. (-0.9659 + -0.2588i).       -0.9659 - 0.2588i
  PUCCH0 alpha * n + r = ( 4 *  2 +  9) mod 24 = 17/24 cyc. (-0.2588 + -0.9659i).       -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  3 +  3) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).       -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  4 + 15) mod 24 =  7/24 cyc. (-0.2588 + 00.9659i).       -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  5 +  9) mod 24 =  5/24 cyc. (00.2588 + 00.9659i).        0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  6 + 21) mod 24 = 21/24 cyc. (00.7071 + -0.7071i).        0.7071 - 0.7071i
  PUCCH0 alpha * n + r = ( 4 *  7 +  3) mod 24 =  7/24 cyc. (-0.2588 + 00.9659i).       -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  8 +  9) mod 24 = 17/24 cyc. (-0.2588 + -0.9659i).       -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = ( 4 *  9 + 15) mod 24 =  3/24 cyc. (00.7071 + 00.7071i).        0.7071 + 0.7071i
  PUCCH0 alpha * n + r = ( 4 * 10 +  9) mod 24 =  1/24 cyc. (00.9659 + 00.2588i).        0.9659 + 0.2588i
  PUCCH0 alpha * n + r = ( 4 * 11 + 15) mod 24 = 11/24 cyc. (-0.9659 + 00.2588i).       -0.9659 + 0.2588i

  PUCCH 0. [symStart nPUCCHSym] = [ 4  2]
  ack = 3 (2 bit), sr = 1 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 1
  mcs = 7

  PUCCH0 alpha * n + r = (10 *  0 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).   -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = (10 *  1 +  9) mod 24 = 19/24 cyc. (00.2588 + -0.9659i).    0.2588 - 0.9659i
  PUCCH0 alpha * n + r = (10 *  2 +  9) mod 24 =  5/24 cyc. (00.2588 + 00.9659i).    0.2588 + 0.9659i
  PUCCH0 alpha * n + r = (10 *  3 +  3) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 *  4 + 15) mod 24 =  7/24 cyc. (-0.2588 + 00.9659i).   -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = (10 *  5 +  9) mod 24 = 11/24 cyc. (-0.9659 + 00.2588i).   -0.9659 + 0.2588i
  PUCCH0 alpha * n + r = (10 *  6 + 21) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 *  7 +  3) mod 24 =  1/24 cyc. (00.9659 + 00.2588i).    0.9659 + 0.2588i
  PUCCH0 alpha * n + r = (10 *  8 +  9) mod 24 = 17/24 cyc. (-0.2588 + -0.9659i).   -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = (10 *  9 + 15) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 * 10 +  9) mod 24 = 13/24 cyc. (-0.9659 + -0.2588i).   -0.9659 - 0.2588i
  PUCCH0 alpha * n + r = (10 * 11 + 15) mod 24 =  5/24 cyc. (00.2588 + 00.9659i).    0.2588 + 0.9659i
  PUCCH0 alpha * n + r = (10 *  0 + 15) mod 24 = 15/24 cyc. (-0.7071 + -0.7071i).   -0.7071 - 0.7071i
  PUCCH0 alpha * n + r = (10 *  1 +  9) mod 24 = 19/24 cyc. (00.2588 + -0.9659i).    0.2588 - 0.9659i
  PUCCH0 alpha * n + r = (10 *  2 +  9) mod 24 =  5/24 cyc. (00.2588 + 00.9659i).    0.2588 + 0.9659i
  PUCCH0 alpha * n + r = (10 *  3 +  3) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 *  4 + 15) mod 24 =  7/24 cyc. (-0.2588 + 00.9659i).   -0.2588 + 0.9659i
  PUCCH0 alpha * n + r = (10 *  5 +  9) mod 24 = 11/24 cyc. (-0.9659 + 00.2588i).   -0.9659 + 0.2588i
  PUCCH0 alpha * n + r = (10 *  6 + 21) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 *  7 +  3) mod 24 =  1/24 cyc. (00.9659 + 00.2588i).    0.9659 + 0.2588i
  PUCCH0 alpha * n + r = (10 *  8 +  9) mod 24 = 17/24 cyc. (-0.2588 + -0.9659i).   -0.2588 - 0.9659i
  PUCCH0 alpha * n + r = (10 *  9 + 15) mod 24 =  9/24 cyc. (-0.7071 + 00.7071i).   -0.7071 + 0.7071i
  PUCCH0 alpha * n + r = (10 * 10 +  9) mod 24 = 13/24 cyc. (-0.9659 + -0.2588i).   -0.9659 - 0.2588i
  PUCCH0 alpha * n + r = (10 * 11 + 15) mod 24 =  5/24 cyc. (00.2588 + 00.9659i).    0.2588 + 0.9659i

  PUCCH 0. [symStart nPUCCHSym] = [ 4  2]
  ack = 3 (2 bit), sr = 1 (1 bit)
  m0, nslot, nid = 5, 0, 512
  occi = 0
  mcs = 7
*/
/* PUCCH1
  |TESTBENCH  | y(n)  | wi(m)y(n) |

  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  0 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i). wi_phi =  0/24 cyc        -0.0000 + 1.0000i         -0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  1 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i). wi_phi =  0/24 cyc        -0.8660 - 0.5000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  2 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i). wi_phi =  0/24 cyc         0.5000 + 0.8660i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  3 +  3) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i). wi_phi =  0/24 cyc        -1.0000 + 0.0000i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  4 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i). wi_phi =  0/24 cyc        -0.8660 - 0.5000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  5 +  9) mod 24 = 22/24 cyc. (00.8660 + -0.5000i). wi_phi =  0/24 cyc         0.8660 - 0.5000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  6 + 21) mod 24 =  0/24 cyc. (01.0000 + 00.0000i). wi_phi =  0/24 cyc         1.0000 - 0.0000i          1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  7 +  3) mod 24 = 20/24 cyc. (00.5000 + -0.8660i). wi_phi =  0/24 cyc         0.5000 - 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  8 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i). wi_phi =  0/24 cyc        -0.5000 - 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 *  9 + 15) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i). wi_phi =  0/24 cyc        -1.0000 - 0.0000i         -1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 * 10 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i). wi_phi =  0/24 cyc         0.5000 - 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 + 15 + 14 * 11 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i). wi_phi =  0/24 cyc        -0.5000 - 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  0 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i). wi_phi =  8/24 cyc        -0.0000 + 1.0000i         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  1 +  9) mod 24 =  6/24 cyc. (00.0000 + 01.0000i). wi_phi =  8/24 cyc         0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  2 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i). wi_phi =  8/24 cyc         0.5000 - 0.8660i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  3 +  3) mod 24 = 20/24 cyc. (00.5000 + -0.8660i). wi_phi =  8/24 cyc        -1.0000 + 0.0000i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  4 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i). wi_phi =  8/24 cyc         0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  5 +  9) mod 24 = 22/24 cyc. (00.8660 + -0.5000i). wi_phi =  8/24 cyc        -0.8660 - 0.5000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  6 + 21) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i). wi_phi =  8/24 cyc         1.0000 - 0.0000i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  7 +  3) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i). wi_phi =  8/24 cyc         0.5000 + 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  8 +  9) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i). wi_phi =  8/24 cyc        -0.5000 + 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 *  9 + 15) mod 24 = 20/24 cyc. (00.5000 + -0.8660i). wi_phi =  8/24 cyc        -1.0000 + 0.0000i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 * 10 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i). wi_phi =  8/24 cyc         0.5000 + 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 + 15 + 22 * 11 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i). wi_phi =  8/24 cyc        -0.5000 + 0.8660i         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  0 + 15) mod 24 = 22/24 cyc. (00.8660 + -0.5000i). wi_phi = 16/24 cyc        -0.0000 + 1.0000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  1 +  9) mod 24 = 12/24 cyc. (-1.0000 + 00.0000i). wi_phi = 16/24 cyc         0.5000 - 0.8660i         -1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  2 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i). wi_phi = 16/24 cyc        -0.5000 - 0.8660i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  3 +  3) mod 24 = 22/24 cyc. (00.8660 + -0.5000i). wi_phi = 16/24 cyc         0.0000 + 1.0000i          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  4 + 15) mod 24 =  6/24 cyc. (00.0000 + 01.0000i). wi_phi = 16/24 cyc        -0.8660 - 0.5000i         -0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  5 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i). wi_phi = 16/24 cyc         0.5000 + 0.8660i          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  6 + 21) mod 24 =  4/24 cyc. (00.5000 + 00.8660i). wi_phi = 16/24 cyc        -1.0000 + 0.0000i          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  7 +  3) mod 24 =  6/24 cyc. (00.0000 + 01.0000i). wi_phi = 16/24 cyc        -0.8660 - 0.5000i          0.0000 + 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  8 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i). wi_phi = 16/24 cyc        -0.5000 - 0.8660i         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 *  9 + 15) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i). wi_phi = 16/24 cyc         0.0000 - 1.0000i         -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 * 10 +  9) mod 24 =  0/24 cyc. (01.0000 + 00.0000i). wi_phi = 16/24 cyc        -0.5000 + 0.8660i          1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 + 15 + 20 * 11 + 15) mod 24 =  2/24 cyc. (00.8660 + 00.5000i). wi_phi = 16/24 cyc        -0.8660 + 0.5000i          0.8660 + 0.5000i

  PUCCH 1. [symStart nPUCCHSym] = [ 4  7]
  ack = 1 (1 bit), sr = 0 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 1
  mcs = 0

  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  0 + 15) mod 24 =  0/24 cyc. (01.0000 + 00.0000i)          1.0000 + 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  1 +  9) mod 24 =  4/24 cyc. (00.5000 + 00.8660i)          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  2 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  3 +  3) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)         -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  4 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i)         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  5 +  9) mod 24 = 20/24 cyc. (00.5000 + -0.8660i)          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  6 + 21) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)         -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  7 +  3) mod 24 = 10/24 cyc. (-0.8660 + 00.5000i)         -0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  8 +  9) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 *  9 + 15) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)          0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 * 10 +  9) mod 24 = 22/24 cyc. (00.8660 + -0.5000i)          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 0 +  9 + 10 * 11 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  0 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i)         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  1 +  9) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  2 +  9) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)         -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  3 +  3) mod 24 =  4/24 cyc. (00.5000 + 00.8660i)          0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  4 + 15) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i)         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  5 +  9) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)         -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  6 + 21) mod 24 = 22/24 cyc. (00.8660 + -0.5000i)          0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  7 +  3) mod 24 = 20/24 cyc. (00.5000 + -0.8660i)          0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  8 +  9) mod 24 = 18/24 cyc. (00.0000 + -1.0000i)         -0.0000 - 1.0000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 *  9 + 15) mod 24 = 16/24 cyc. (-0.5000 + -0.8660i)         -0.5000 - 0.8660i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 * 10 +  9) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = (16 +  9 + 16 * 11 + 15) mod 24 =  0/24 cyc. (01.0000 + 00.0000i)          1.0000 - 0.0000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  0 + 15) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i)         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  1 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i)         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  2 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  3 +  3) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  4 + 15) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i)         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  5 +  9) mod 24 =  8/24 cyc. (-0.5000 + 00.8660i)         -0.5000 + 0.8660i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  6 + 21) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  7 +  3) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  8 +  9) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 *  9 + 15) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 * 10 +  9) mod 24 = 14/24 cyc. (-0.8660 + -0.5000i)         -0.8660 - 0.5000i
  PUCCH1 z = w + d + alpha * n + r = ( 8 +  9 +  6 * 11 + 15) mod 24 =  2/24 cyc. (00.8660 + 00.5000i)          0.8660 + 0.5000i

  PUCCH 1. [symStart nPUCCHSym] = [ 3  7]
  ack = 1 (2 bit), sr = 0 (1 bit)
  m0, nslot, nid = 5, 3, 512
  occi = 2
  mcs = 0
*/
/* PUCCH2
  PUCCH2 nid = 512, rnti = 56789 => cinit = 1860862464
  PUCCH2. d = QPSK(b( 0) ^ c( 0)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH2. d = QPSK(b( 1) ^ c( 1)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH2. d = QPSK(b( 2) ^ c( 2)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH2. d = QPSK(b( 3) ^ c( 3)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH2. d = QPSK(b( 4) ^ c( 4)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH2. d = QPSK(b( 5) ^ c( 5)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH2. d = QPSK(b( 6) ^ c( 6)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH2. d = QPSK(b( 7) ^ c( 7)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
*/

/* PUCCH3
  PUCCH3 nid = 512, rnti = 56789 => cinit = 1860862464
  PUCCH3. d = QPSK(b( 0) ^ c( 0)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 1) ^ c( 1)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 2) ^ c( 2)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b( 3) ^ c( 3)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 4) ^ c( 4)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b( 5) ^ c( 5)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 6) ^ c( 6)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 7) ^ c( 7)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 8) ^ c( 8)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b( 9) ^ c( 9)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(10) ^ c(10)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(11) ^ c(11)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(12) ^ c(12)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(13) ^ c(13)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(14) ^ c(14)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(15) ^ c(15)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(16) ^ c(16)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(17) ^ c(17)) = QPSK(00) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(18) ^ c(18)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(19) ^ c(19)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(20) ^ c(20)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(21) ^ c(21)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(22) ^ c(22)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(23) ^ c(23)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(24) ^ c(24)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(25) ^ c(25)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(26) ^ c(26)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(27) ^ c(27)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(28) ^ c(28)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(29) ^ c(29)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(30) ^ c(30)) = QPSK(11) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(31) ^ c(31)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(32) ^ c(32)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = QPSK(b(33) ^ c(33)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(34) ^ c(34)) = QPSK(10) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = QPSK(b(35) ^ c(35)) = QPSK(01) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i

  PUCCH3 nid = 512, rnti = 56789 => cinit = 1860862464
  PUCCH3. d = pi/2-BPSK(b( 0) ^ c( 0)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 1) ^ c( 1)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 2) ^ c( 2)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 3) ^ c( 3)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 4) ^ c( 4)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 5) ^ c( 5)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 6) ^ c( 6)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 7) ^ c( 7)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 8) ^ c( 8)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b( 9) ^ c( 9)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(10) ^ c(10)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(11) ^ c(11)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(12) ^ c(12)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(13) ^ c(13)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(14) ^ c(14)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(15) ^ c(15)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(16) ^ c(16)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(17) ^ c(17)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(18) ^ c(18)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(19) ^ c(19)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(20) ^ c(20)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(21) ^ c(21)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(22) ^ c(22)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(23) ^ c(23)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(24) ^ c(24)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(25) ^ c(25)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(26) ^ c(26)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(27) ^ c(27)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(28) ^ c(28)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(29) ^ c(29)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(30) ^ c(30)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(31) ^ c(31)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(32) ^ c(32)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(33) ^ c(33)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(34) ^ c(34)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(35) ^ c(35)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(36) ^ c(36)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(37) ^ c(37)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(38) ^ c(38)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(39) ^ c(39)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(40) ^ c(40)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(41) ^ c(41)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(42) ^ c(42)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(43) ^ c(43)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(44) ^ c(44)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(45) ^ c(45)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(46) ^ c(46)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(47) ^ c(47)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(48) ^ c(48)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(49) ^ c(49)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(50) ^ c(50)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(51) ^ c(51)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(52) ^ c(52)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(53) ^ c(53)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(54) ^ c(54)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(55) ^ c(55)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(56) ^ c(56)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(57) ^ c(57)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(58) ^ c(58)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(59) ^ c(59)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(60) ^ c(60)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(61) ^ c(61)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(62) ^ c(62)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(63) ^ c(63)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(64) ^ c(64)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(65) ^ c(65)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(66) ^ c(66)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(67) ^ c(67)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(68) ^ c(68)) = pi/2-BPSK( 0) =  3/24 cyc (00.7071 + 00.7071i)        0.7071 + 0.7071i
  PUCCH3. d = pi/2-BPSK(b(69) ^ c(69)) = pi/2-BPSK( 1) = 21/24 cyc (00.7071 + -0.7071i)        0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(70) ^ c(70)) = pi/2-BPSK( 1) = 15/24 cyc (-0.7071 + -0.7071i)       -0.7071 - 0.7071i
  PUCCH3. d = pi/2-BPSK(b(71) ^ c(71)) = pi/2-BPSK( 0) =  9/24 cyc (-0.7071 + 00.7071i)       -0.7071 + 0.7071i
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

  localparam test_symStart = 3;
  localparam test_nPUCCHSym = 7;  // nPUCCHSym = 7 => nSF = floor(nPUCCHSym/2) = 3

  localparam test_ack = 2'b01;  // ack = [bit1; bit0]
  localparam test_lenACK = 2;
  localparam test_sr = 0;
  localparam test_lenSR = 1;

  localparam test_m0 = 5;  // initialCS
  localparam test_nslot = 3;
  localparam test_nid = 512;

  localparam test_occi = 2;
`endif
`ifdef TEST_F2
  localparam VCD_FILE = "vcds/pucch2_tb.vcd";
  localparam UCICW_FILE = "tb/pucch/uciCW_F2.txt";

  localparam test_pucch_format = 2;

  localparam test_rnti = 56789;  // F2
  localparam test_nid = 512;

  localparam lenUCI = 16;

  reg test_uciCW[0:lenUCI-1];
  integer test_uciCW_index;
  initial $readmemb(UCICW_FILE, test_uciCW);
`endif
`ifdef TEST_F3
  localparam VCD_FILE = "vcds/pucch3_tb.vcd";
  localparam UCICW_FILE = "tb/pucch/uciCW_F3.txt";

  localparam test_pucch_format = 3;

  localparam test_rnti = 56789;  // F2
  localparam test_nid = 512;

  localparam test_Mrb = 3;  // F3
  localparam test_pi2bpsk_qpsk = 1;  // 1: pi/2 BPSK, 0: QPSK

  localparam lenUCI = 2 * (test_Mrb * nRBSC);

  reg test_uciCW[0:lenUCI-1];
  integer test_uciCW_index;
  initial $readmemb(UCICW_FILE, test_uciCW);
`endif

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
`endif
`ifdef TEST_F1
      test_f0f1(test_pucch_format,  //
                test_symStart, test_nPUCCHSym,  //
                test_ack, test_lenACK, test_sr, test_lenSR,  //
                test_m0, test_nslot, test_nid,  //
                test_occi);
`endif
`ifdef TEST_F2
      test_f2(test_pucch_format,  //
              test_nid, test_rnti,  //
              lenUCI);
`endif
`ifdef TEST_F3
      // test_f3(test_nid, test_rnti,  //
      //         test_Mrb,  //
      //         lenUCI,  //
      //         test_pi2bpsk_qpsk);  //! The number of 2-bit value must be an integer multiple of (allocated number of subcarriers Msc = Mrb * nRBSC)
`endif
      nop_clk(10);
      $finish;
    end
  end

  integer count_pucch = 0;
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
          // $display("wi_phi = %2d/24 cyc (is supported = %1b)", pucch_dut.spread_wi_phi_cyc_24, pucch_dut.spread_is_supported);
          $display();
        end
        2: begin
          count_pucch <= count_pucch + 1;
          $write("PUCCH2. d = QPSK(b(%2d) ^ c(%2d)) = QPSK(%2b)",  //
                 count_pucch, count_pucch, pucch_dut.scrambler_scrambed_2bit);
          $write(" = %2d/24 cyc (%07.4f + %07.4fi)",  //
                 pucch_dut.d_qpsk, to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
          $display();
        end
        3: begin
          count_pucch <= count_pucch + 1;
          if (pucch_dut.i_pi2bpsk_qpsk) begin
            $write("PUCCH3. d = pi/2-BPSK(b(%2d) ^ c(%2d)) = pi/2-BPSK(%2b)",  //
                   count_pucch, count_pucch, pucch_dut.scrambler_scrambed_bit);
            $write(" = %2d/24 cyc (%07.4f + %07.4fi)",  //
                   pucch_dut.d_pi2bpsk, to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
            $display();
          end else begin
            $write("PUCCH3. d = QPSK(b(%2d) ^ c(%2d)) = QPSK(%2b)",  //
                   count_pucch, count_pucch, pucch_dut.scrambler_scrambed_2bit);
            $write(" = %2d/24 cyc (%07.4f + %07.4fi)",  //
                   pucch_dut.d_qpsk, to_real(o_pucch_re) / (2 ** 15), to_real(o_pucch_im) / (2 ** 15));
            $display();
          end
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

`ifdef TEST_F3
  task automatic test_f3;
    input integer nid;
    input integer rnti;
    input integer Mrb;
    input integer get;
    input pi2bpsk_qpsk;
    integer uciCW;
    begin
      // @(negedge clk);
      i_pucch_format   = 3;
      i_nid            = nid;
      i_rnti           = rnti;
      i_Mrb            = Mrb;
      i_pi2bpsk_qpsk   = pi2bpsk_qpsk;

      test_uciCW_index = 0;

      repeat (3) @(negedge clk);
      i_start = 1;
      @(negedge clk);
      i_start = 0;

      $display("PUCCH3 nid = %1d, rnti = %1d => cinit = %1d", nid, rnti, pucch_dut.c_seq_gen_cinit);

      repeat (get) begin
        i_uciCW = test_uciCW[test_uciCW_index];
        test_uciCW_index = test_uciCW_index + 1;

        i_uciCW_valid = 1;
        @(negedge clk);
        i_uciCW_valid = 0;
      end
    end
  endtask  //automatic
`endif
`ifdef TEST_F2
  task automatic test_f2;
    input integer pucch_format;
    input integer nid;
    input integer rnti;
    input integer get;
    integer uciCW;
    begin
      // @(negedge clk);
      i_pucch_format   = pucch_format;
      i_nid            = nid;
      i_rnti           = rnti;

      test_uciCW_index = 0;

      repeat (3) @(negedge clk);
      i_start = 1;
      @(negedge clk);
      i_start = 0;

      $display("PUCCH2 nid = %1d, rnti = %1d => cinit = %1d", nid, rnti, pucch_dut.c_seq_gen_cinit);

      repeat (get) begin
        i_uciCW = test_uciCW[test_uciCW_index];
        test_uciCW_index = test_uciCW_index + 1;

        i_uciCW_valid = 1;
        @(negedge clk);
        i_uciCW_valid = 0;
      end
    end
  endtask  //automatic
`endif

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

      repeat (10) @(negedge clk);
      i_start = 1;
      @(negedge clk);
      i_start = 0;

      @(negedge o_done);
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
  reg         i_uciCW = 0;  //! [Format 2] Encoded UCI codeword as per TS 38.212 Section 6.3.1
  reg         i_uciCW_valid = 0;  //! [Format 2] uciCW is valid and ready to continue generate PUCCH sequence

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
      repeat (clks) @(negedge clk);
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
