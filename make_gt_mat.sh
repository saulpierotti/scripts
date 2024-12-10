#!/bin/bash
# Make a simple genotype matrix with header from a vcf file

FIXED_COLS="$(mktemp)"
GT_COLS="$(mktemp)"
HEADER="$(mktemp)"

echo -en "chr\npos\nref\nalt\n" > $FIXED_COLS
bcftools query -l $1 > $GT_COLS

cat $FIXED_COLS $GT_COLS \
| tr '\n' ',' \
| sed 's/,$/\n/g' \
> $HEADER

bcftools query -f "%CHROM,%POS,%REF,%ALT[,%GT]" $1 \
| sed -e 's%0[/|]0%hom_ref%g' \
    -e 's%0[/|]1%het%g' \
    -e 's%1|0%het%' \
    -e 's%1[/|]1%hom_alt%g' \
    -e 's%\./\.%%g' \
| cat $HEADER -
