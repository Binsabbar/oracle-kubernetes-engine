data "oci_identity_fault_domains" "fault_domains" {
    availability_domain = data.oci_identity_availability_domain.ad_1.name
    compartment_id = oci_identity_compartment.compartment.id
}

data "oci_identity_availability_domains" "availability_domains" {
    compartment_id = oci_identity_compartment.compartment.id
}

data "oci_identity_availability_domain" "ad_1" {
  compartment_id = oci_identity_compartment.compartment.id
  ad_number      = 1
}