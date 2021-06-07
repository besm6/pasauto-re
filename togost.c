/*
 * Converts a Pascal-Autocode program text from UTF-8 to GOST 10859.
 * Optionally converts repeated spaces outside of string literals
 * to bytes 0200 + the number of spaces.
 * 0201 is thus a synonym for "space" (017).
 * Optionally converts the := operator to byte 0200, internally used
 * by the compiler and conveniently not filtered out in the input.
 * Optionally skips line comments introduced by the % sign as well as preceding spaces.
 * Characters & and | become Boolean AND and OR symbols, resp.
 * Backslash \ may be used as a replacement for the character escape symbol ≡
 *
 * Copyright 2021 Leonid Broukhis
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

unsigned char
unicode_to_gost (unsigned short val)
{
    static const unsigned char tab0 [256] = {
/* 00 - 07 */	017,	017,	017,	017,	017,	017,	017,	017,
/* 08 - 0f */	017,	017,	0175,	017,	017,	017, 	017,	017,
/* 10 - 17 */	017,	017,	017,	017,	017,	017,	017,	017,
/* 18 - 1f */	017,	017,	017,	017,	017,	017,	017,	017,
/*  !"#$%&' */	0017,	0133,	0134,	0034,	0127,	0126,	0121,	0033,
/* ()*+,-./ */	0022,	0023,	0031,	0012,	0015,	0013,	0016,	0014,
/* 01234567 */	0000,	0001,	0002,	0003,	0004,	0005,	0006,	0007,
/* 89:;<=>? */	0010,	0011,	0037,	0026,	0035,	0025,	0036,	0136,
/* @ABCDEFG */	0021,	0040,	0042,	0061,	0077,	0045,	0100,	0101,
/* HIJKLMNO */	0055,	0102,	0103,	0052,	0104,	0054,	0105,	0056,
/* PQRSTUVW */	0060,	0106,	0107,	0110,	0062,	0111,	0112,	0113,
/* XYZ[\]^_ */	0065,	0063,	0114,	0027,	0125,	0030,	0115,	0132, // \ becomes ≡
/* `abcdefg */	0032,	0040,	0042,	0061,	0077,	0045,	0100,	0101,
/* hijklmno */	0055,	0102,	0103,	0052,	0104,	0054,	0105,	0056,
/* pqrstuvw */	0060,	0106,	0107,	0110,	0062,	0111,	0112,	0113,
/* xyz{|}~  */	0065,	0063,	0114,	0125,	0120,	017,	0123,	017,  // | becomes ∨ (or)
/* 80 - 87 */	017,	017,	017,	017,	017,	017,	017,	017,
/* 88 - 8f */	017,	017,	017,	017,	017,	017,	017,	017,
/* 90 - 97 */	017,	017,	017,	017,	017,	017,	017,	017,
/* 98 - 9f */	017,	017,	017,	017,	017,	017,	017,	017,
/* a0 - a7 */	017,	017,	017,	017,	017,	017,	0130,	017,  // ¦ becomes |
/* a8 - af */	017,	017,	017,	017,	0123,	017,	017,	017,
/* b0 - b7 */	0136,	017,	017,	017,	017,	017,	017,	017,
/* b8 - bf */	017,	017,	017,	017,	017,	017,	017,	017,
/* c0 - c7 */	017,	017,	017,	017,	017,	017,	017,	017,
/* c8 - cf */	017,	017,	017,	017,	017,	017,	017,	017,
/* d0 - d7 */	017,	017,	017,	017,	017,	017,	017,	0024,
/* d8 - df */	017,	017,	017,	017,	017,	017,	017,	017,
/* e0 - e7 */	017,	017,	017,	017,	017,	017,	017,	017,
/* e8 - ef */	017,	017,	017,	017,	017,	017,	017,	017,
/* f0 - f7 */	017,	017,	017,	017,	017,	017,	017,	0124,
/* f8 - ff */ 	017,	017,	017,	017,	017,	017,	017,	017,
    };
    switch (val >> 8) {
    case 0x00:
        return tab0 [val];
    case 0x04:
        switch ((unsigned char) val) {
        case 0x10: return 0040;
        case 0x11: return 0041;
        case 0x12: return 0042;
        case 0x13: return 0043;
        case 0x14: return 0044;
        case 0x15: return 0045;
        case 0x16: return 0046;
        case 0x17: return 0047;
        case 0x18: return 0050;
        case 0x19: return 0051;
        case 0x1a: return 0052;
        case 0x1b: return 0053;
        case 0x1c: return 0054;
        case 0x1d: return 0055;
        case 0x1e: return 0056;
        case 0x1f: return 0057;
        case 0x20: return 0060;
        case 0x21: return 0061;
        case 0x22: return 0062;
        case 0x23: return 0063;
        case 0x24: return 0064;
        case 0x25: return 0065;
        case 0x26: return 0066;
        case 0x27: return 0067;
        case 0x28: return 0070;
        case 0x29: return 0071;
        case 0x2a: return 0135;
        case 0x2b: return 0072;
        case 0x2c: return 0073;
        case 0x2d: return 0074;
        case 0x2e: return 0075;
        case 0x2f: return 0076;
        case 0x30: return 0040;
        case 0x31: return 0041;
        case 0x32: return 0042;
        case 0x33: return 0043;
        case 0x34: return 0044;
        case 0x35: return 0045;
        case 0x36: return 0046;
        case 0x37: return 0047;
        case 0x38: return 0050;
        case 0x39: return 0051;
        case 0x3a: return 0052;
        case 0x3b: return 0053;
        case 0x3c: return 0054;
        case 0x3d: return 0055;
        case 0x3e: return 0056;
        case 0x3f: return 0057;
        case 0x40: return 0060;
        case 0x41: return 0061;
        case 0x42: return 0062;
        case 0x43: return 0063;
        case 0x44: return 0064;
        case 0x45: return 0065;
        case 0x46: return 0066;
        case 0x47: return 0067;
        case 0x48: return 0070;
        case 0x49: return 0071;
        case 0x4a: return 0135;
        case 0x4b: return 0072;
        case 0x4c: return 0073;
        case 0x4d: return 0074;
        case 0x4e: return 0075;
        case 0x4f: return 0076;
        }
        break;
    case 0x20:
        switch ((unsigned char) val) {
        case 0x15: return 0131;
        case 0x18: return 0032;
        case 0x19: return 0033;
        case 0x32: return 0137;
        case 0x3e: return 0115;
        }
        break;
    case 0x21:
        switch ((unsigned char) val) {
        case 0x2f: return 0020;
        case 0x91: return 0021;
        }
        break;
    case 0x22:
        switch ((unsigned char) val) {
        case 0x27: return 0121;
        case 0x28: return 0120;
        case 0x60: return 0034;
        case 0x61: return 0125;
        case 0x64: return 0116;
        case 0x65: return 0117;
        case 0x83: return 0122;
        }
        break;
    case 0x25:
        switch ((unsigned char) val) {
        case 0xc7: return 0127;
        case 0xca: return 0127;
        }
        break;
    }
    return 017;
}

static int
utf8_getc_raw (FILE *fin)
{
    int c1, c2, c3;
    c1 = getc (fin);
    if (c1 < 0 || ! (c1 & 0x80))
        return c1;
    c2 = getc (fin);
    if (! (c1 & 0x20))
        return (c1 & 0x1f) << 6 | (c2 & 0x3f);
    c3 = getc (fin);
    return (c1 & 0x0f) << 12 | (c2 & 0x3f) << 6 | (c3 & 0x3f);

}

static int
utf8_getc (FILE *fin)
{
    int c;
    /* Skip zero width no-break space. */
    while ((c = utf8_getc_raw (fin)) == 0xFEFF);
    return c;
}

static void
utf8_putc (unsigned short ch, FILE *fout)
{
    if (ch < 0x80) {
        putc (ch, fout);
        return;
    }
    if (ch < 0x800) {
        putc (ch >> 6 | 0xc0, fout);
        putc ((ch & 0x3f) | 0x80, fout);
        return;
    }
    putc (ch >> 12 | 0xe0, fout);
    putc (((ch >> 6) & 0x3f) | 0x80, fout);
    putc ((ch & 0x3f) | 0x80, fout);
}

int main(int argc, char * argv[]) {
    int c, g, nsp = 0, quoted = 0, comment = 0, colon = 0;
    int convert_assign = 0, compress_spaces = 0, convert_single_space = 0, skip_percent = 0;
    const char * usage = "Usage: %s [-c] [-s] [-a] [-p] < utf8_file > gost_file\n\
\t -c - compress spaces\n\
\t -s - convert single space to byte 0201\n\
\t -p - skip %%-style line comments\n\
\t -a - convert the assignment operator := to byte 0200\n";
    char opt;
    while ((opt = getopt(argc, argv, "csap")) != -1) {
        switch (opt) {
        case 'c': compress_spaces = 1; break;
        case 's': convert_single_space = 1; break;
        case 'a': convert_assign = 1; break;
        case 'p': skip_percent = 1; break;
        case '?': fprintf(stderr, usage, argv[0]);
            exit(EXIT_FAILURE);
        }
    }
    if (optind != argc) {
        fprintf (stderr, usage, argv[0]);
        exit (EXIT_FAILURE);
    }
    
    while ((c = utf8_getc(stdin)) != EOF) {
	if (comment && c != '\n') continue;
	comment = 0;
	g = unicode_to_gost(c);
	if (c != ' ' && g == 017) {
		fprintf(stderr, "Bad character U+%04x ", c);
		utf8_putc(c, stderr);
		fprintf(stderr, " ignored\n");
 	} else if (!quoted && g == 017 && compress_spaces) { ++nsp; continue; }
	else {
		if (!quoted && skip_percent && c == '%') {
			if (colon) putchar(unicode_to_gost(':'));
			nsp = colon = 0; comment = 1;
			continue;
		}
		if (nsp) putchar(!convert_single_space && nsp == 1 ? 017 : 0200+nsp);
		nsp = 0;
		if (convert_assign) {
                    if (colon) {
			colon = c == ':'; 
			if (c == '=') { putchar(128); continue; }
			putchar(unicode_to_gost(':'));
                    } else if (!quoted && c == ':') { colon = 1; continue; }
		}
		putchar(convert_single_space && g == 017 ? 0201 : g);
        }
	if (c == '\'') quoted = !quoted;
    }
    putchar(0172);
    return EXIT_SUCCESS;
}
