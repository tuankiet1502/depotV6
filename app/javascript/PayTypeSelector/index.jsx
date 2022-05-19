import React, { useState } from "react"
import NoPayType from './NoPayType'
import CreditCardPayType from './CreditCardPayType'
import CheckPayType from './CheckPayType'
import PurchaseOrderPayType from './PurchaseOrderPayType'

const PayTypeSelector = () => {
    const [payType, setPayType] = useState()

    const handlePayTypeSelected = (e) => {
        setPayType(e.target.value)
    }
    const PayTypeCustomComponent = () => {
        if(payType === "Credit card") {
            return <CreditCardPayType/>
        } 
        else if (payType === "Check") {
            return <CheckPayType/>
        }
        else if (payType === "Purchase order") {
            return <PurchaseOrderPayType/>
        }
        else return <NoPayType/>
    }
    return (
        <>
        <div className="field">
            <label htmlFor="order_pay_type">
               {I18n.t('orders.form.pay_type')}
            </label>
            <select id="order_pay_type" name="order[pay_type]" onChange={handlePayTypeSelected}>
            <option value="">{I18n.t('orders.form.pay_prompt_html')}</option>
            <option value="Check">{I18n.t('orders.form.pay_types.check')}</option>
            <option value="Credit card">{I18n.t('orders.form.pay_types.credit_card')}</option>
            <option value="Purchase order">{I18n.t('orders.form.pay_types.purchase_order')}</option>
            </select>
        </div>
        <PayTypeCustomComponent />
        </>
    )
}
export default PayTypeSelector