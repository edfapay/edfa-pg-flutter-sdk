/*
 * Property of EdfaPg (https://edfapay.com).
 */

package com.edfapg.sample.ui

import android.os.Bundle
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.get
import com.edfapg.sample.R
import com.edfapg.sample.app.EdfaPgTransactionStorage
import com.edfapg.sample.app.preattyPrint
import com.edfapg.sample.databinding.ActivityGetTransStatusBinding
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusCallback
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusResponse
import com.edfapg.sdk.model.response.gettransactionstatus.EdfaPgGetTransactionStatusResult

class EdfaPgGetTransStatusActivity : AppCompatActivity(R.layout.activity_get_trans_status) {

    private lateinit var binding: ActivityGetTransStatusBinding
    private lateinit var edfapayTransactionStorage: EdfaPgTransactionStorage

    private var selectedTransaction: EdfaPgTransactionStorage.Transaction? = null
    private var transactions: List<EdfaPgTransactionStorage.Transaction>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        edfapayTransactionStorage = EdfaPgTransactionStorage(this)
        binding = ActivityGetTransStatusBinding.inflate(layoutInflater)
        setContentView(binding.root)

        configureView()
    }

    private fun configureView() {
        binding.btnGetTransStatus.setOnClickListener {
            executeRequest()
        }

        transactions = edfapayTransactionStorage.getAllTransactions()
        invalidateSpinner()
    }

    private fun invalidateSpinner() {
        binding.spinnerTransactions.apply {
            val prettyTransactions = transactions
                .orEmpty()
                .map { it.toString() }
                .toMutableList()
                .apply {
                    add(0, "Select Transaction")
                }

            adapter = object : ArrayAdapter<String>(
                this@EdfaPgGetTransStatusActivity,
                android.R.layout.simple_spinner_dropdown_item,
                prettyTransactions
            ) {
                override fun isEnabled(position: Int): Boolean {
                    return position != 0
                }

                override fun getDropDownView(position: Int, convertView: View?, parent: ViewGroup): View {
                    return super.getDropDownView(position, convertView, parent).apply {
                        alpha = if (position == 0) 0.5F else 1.0F
                    }
                }
            }

            onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                    parent?.get(0)?.alpha = if (position == 0) 0.5F else 1.0F

                    if (transactions.isNullOrEmpty()) {
                        invalidateSelectedTransaction()
                        return
                    }

                    selectedTransaction = if (position == 0) {
                        null
                    } else {
                        transactions?.get((position - 1).coerceAtLeast(0))
                    }

                    invalidateSelectedTransaction()
                }

                override fun onNothingSelected(parent: AdapterView<*>?) {
                    selectedTransaction = null
                    invalidateSelectedTransaction()
                }
            }

            invalidateSelectedTransaction()
        }

    }

    private fun invalidateSelectedTransaction() {
        binding.txtSelectedTransaction.text = selectedTransaction?.preattyPrint()
        binding.btnGetTransStatus.isEnabled = selectedTransaction != null
    }

    private fun onRequestStart() {
        binding.progressBar.show()
        binding.txtResponse.text = ""
    }

    private fun onRequestFinish() {
        binding.progressBar.hide()
    }

    private fun executeRequest() {
        selectedTransaction?.let { selectedTransaction ->
            onRequestStart()
            EdfaPgSdk.Adapter.GET_TRANSACTION_STATUS.execute(
                transactionId = selectedTransaction.id,
                payerEmail = selectedTransaction.payerEmail,
                cardNumber = selectedTransaction.cardNumber,
                callback = object : EdfaPgGetTransactionStatusCallback {
                    override fun onResponse(response: EdfaPgGetTransactionStatusResponse) {
                        super.onResponse(response)
                        onRequestFinish()
                        binding.txtResponse.text = response.preattyPrint()
                    }

                    override fun onResult(result: EdfaPgGetTransactionStatusResult) = Unit

                    override fun onError(error: EdfaPgError) = Unit

                    override fun onFailure(throwable: Throwable) {
                        super.onFailure(throwable)
                        onRequestFinish()
                        binding.txtResponse.text = throwable.preattyPrint()
                    }
                }
            )
        } ?: invalidateSelectedTransaction()
    }
}
