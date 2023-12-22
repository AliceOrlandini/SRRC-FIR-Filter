# SRRC-FIR-Filter

Design a digital circuit that realises a FIR (Finite Impulse Response) filter with a SRRC (Square Root Raised Cosine) impulse response and with the following characteristics:
1. Order of the filter $N = 22$
2. Samples per symbol 4
3. A roll-off factor of 0.5

$$y[n] = \sum_{i=0}^{N} c_i \cdot x[n-i]$$

For inputs, outputs and coefficients, use a 16-bit representation.
