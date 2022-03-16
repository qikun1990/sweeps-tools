package com.tangtang.po;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "user_ad_info")
@NamedQuery(name = "UserAdInfo.findAll", query = "SELECT w FROM UserAdInfo w")
public class UserAdInfo implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	@Id
	private String subid;

	@Column(name = "billing_same_as_shipping")
	private Boolean billingSameAsShipping;

	@Column(name = "billing_first_name")
	private String billingFirstName;

	@Column(name = "billing_last_name")
	private String billingLastName;

	@Column(name = "billing_country")
	private String billingCountry;

	@Column(name = "billing_zip")
	private String billingZip;

	@Column(name = "billing_address1")
	private String billingAddress1;

	@Column(name = "billing_address2")
	private String billingAddress2;

	@Column(name = "billing_city")
	private String billingCity;

	@Column(name = "billing_state")
	private String billingState;

	@Column(name = "credit_card_number")
	private String creditCardNumber;

	@Column(name = "credit_card_type")
	private String creditCardType;

	@Column(name = "expmonth")
	private String expmonth;

	@Column(name = "expyear")
	private String expyear;

	@Column(name = "cvv")
	private String CVV;

	public String getSubid() {
		return subid;
	}

	public void setSubid(String subid) {
		this.subid = subid;
	}

	public Boolean getBillingSameAsShipping() {
		return billingSameAsShipping;
	}

	public void setBillingSameAsShipping(Boolean billingSameAsShipping) {
		this.billingSameAsShipping = billingSameAsShipping;
	}

	public String getBillingFirstName() {
		return billingFirstName;
	}

	public void setBillingFirstName(String billingFirstName) {
		this.billingFirstName = billingFirstName;
	}

	public String getBillingLastName() {
		return billingLastName;
	}

	public void setBillingLastName(String billingLastName) {
		this.billingLastName = billingLastName;
	}

	public String getBillingCountry() {
		return billingCountry;
	}

	public void setBillingCountry(String billingCountry) {
		this.billingCountry = billingCountry;
	}

	public String getBillingZip() {
		return billingZip;
	}

	public void setBillingZip(String billingZip) {
		this.billingZip = billingZip;
	}

	public String getBillingAddress1() {
		return billingAddress1;
	}

	public void setBillingAddress1(String billingAddress1) {
		this.billingAddress1 = billingAddress1;
	}

	public String getBillingAddress2() {
		return billingAddress2;
	}

	public void setBillingAddress2(String billingAddress2) {
		this.billingAddress2 = billingAddress2;
	}

	public String getBillingCity() {
		return billingCity;
	}

	public void setBillingCity(String billingCity) {
		this.billingCity = billingCity;
	}

	public String getBillingState() {
		return billingState;
	}

	public void setBillingState(String billingState) {
		this.billingState = billingState;
	}

	public String getCreditCardNumber() {
		return creditCardNumber;
	}

	public void setCreditCardNumber(String creditCardNumber) {
		this.creditCardNumber = creditCardNumber;
	}

	public String getCreditCardType() {
		return creditCardType;
	}

	public void setCreditCardType(String creditCardType) {
		this.creditCardType = creditCardType;
	}

	public String getExpmonth() {
		return expmonth;
	}

	public void setExpmonth(String expmonth) {
		this.expmonth = expmonth;
	}

	public String getExpyear() {
		return expyear;
	}

	public void setExpyear(String expyear) {
		this.expyear = expyear;
	}

	public String getCVV() {
		return CVV;
	}

	public void setCVV(String cVV) {
		CVV = cVV;
	}

}