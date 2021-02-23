RES_NAME="all_for_pdf.md"
echo "Combining all md files into $RES_NAME"

truncate -s 0 $RES_NAME


write_file() {
    echo "writing $2"
    echo "<h1 id=\"$2\"></h1>" >> $RES_NAME
    cat $1 >> $RES_NAME
    echo "\n" >> $RES_NAME
}

replace() {
    # replaces param 1 with param 2 in final file
    perl -pe "s|\Q$1\E|$2|g" $RES_NAME > tmp.md
    mv tmp.md $RES_NAME
}

write_file pdf_header.md 

# 1
# 1.1
write_file 1/swiss_local_routing.md 1.1

# 1.2
write_file 1/ospf_intra_routing.md 1.2

# 1.3
write_file 1/ospf_cost.md 1.3

# 1.4
write_file 1/no_transit_swiss_local.md 1.4

# 1.5
write_file 1/ibgp.md 1.5


# 2
# 2.1
write_file 2/ebgp.md 2.1

# 2.2
write_file 2/ixp_community_vals.md 2.2


# 3
# 3.1
write_file 3/policy_routing.md 3.1

# 3.2
write_file 3/ixp_policy.md 3.2

# 3.3 & 3.4
write_file 3/incoming_balancing.md 3.3/3.4

# 3.5
write_file 3/hijack.md 3.5


replace '[ospf_cost.md](./ospf_cost.md)' '[1.3 Ospf cost](#1.3)'
replace '[3.1: Business Relations](../3/policy_routing.md)' '[3.1: Business Relations](#3.1)'
replace '(../2/ixp_community_vals.md)' '(#2.2)'


echo "Building html..."
pandoc all_for_pdf.md -f markdown -t html -s -c styles.css -o combined_md.html --metadata pagetitle="Telematik 20/21 FU Berlin Mini-Inet AS19"
echo "Save html to pdf"