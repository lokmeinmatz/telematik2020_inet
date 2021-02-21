RES_NAME="all_for_pdf.md"
echo "Combining all md files into $RES_NAME"

truncate -s 0 $RES_NAME


write_file() {
    cat $1 >> $RES_NAME
    echo "\n\n<br/>\n" >> $RES_NAME
}

write_file pdf_header.md

# 1
# 1.1
write_file 1/swiss_local_routing.md

# 1.2
write_file 1/ospf_intra_routing.md

# 1.3
write_file 1/ospf_cost.md

# 1.4
write_file 1/no_transit_swiss_local.md

# 1.5
write_file 1/ibgp.md


# 2
# 2.1
write_file 2/ebgp.md

# 2.2
write_file 2/ixp_community_vals.md


# 3
# 3.1
write_file 3/policy_routing.md