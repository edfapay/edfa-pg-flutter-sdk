/*
 * Property of EdfaPg (https://edfapay.com).
 */

package com.edfapg.sample.app

import android.content.Context
import androidx.core.content.edit
import com.edfapg.sdk.model.api.EdfaPgAction
import com.edfapg.sdk.model.api.EdfaPgResult
import com.edfapg.sdk.model.api.EdfaPgStatus
import com.edfapg.sdk.model.response.base.result.IEdfaPgResult
import com.google.gson.Gson
import java.util.*

internal class EdfaPgTransactionStorage(context: Context) {

    companion object {
        private const val EDFA_PG_TRANSACTION_STORAGE = "EDFA_PG_TRANSACTION_STORAGE"
    }

    private val storage = context.getSharedPreferences(EDFA_PG_TRANSACTION_STORAGE, Context.MODE_PRIVATE)
    private val gson = Gson()

    fun addTransaction(transaction: Transaction) {
        storage.edit {
            putString(
                UUID.randomUUID().toString(),
                gson.toJson(transaction)
            )
        }
    }

    fun getAllTransactions() = storage.all.map {
        gson.fromJson(it.value as String, Transaction::class.java)
    }

    fun getRecurringSaleTransactions() = getAllTransactions().filter {
        it.action == EdfaPgAction.SALE && it.recurringToken.isNotEmpty()
    }

    fun getCaptureTransactions() = getAllTransactions().filter {
        it.action == EdfaPgAction.SALE && it.isAuth
    }

    fun getCreditvoidTransactions() = getAllTransactions().filter {
        it.action == EdfaPgAction.SALE || it.action == EdfaPgAction.CAPTURE || it.isAuth
    }

    fun clearTransactions() = storage.edit {
        clear()
    }

    data class Transaction(
        val payerEmail: String,
        val cardNumber: String,
    ) {
        var id: String = ""
        var action: EdfaPgAction? = null
        var result: EdfaPgResult? = null
        var status: EdfaPgStatus? = null

        var recurringToken: String = ""
        var isAuth: Boolean = false

        fun fill(result: IEdfaPgResult) {
            id = result.transactionId
            action = result.action
            this.result = result.result
            status = result.status
        }
    }
}
