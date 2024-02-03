/*
 * Property of EdfaPg (https://edfapay.com).
 */

package com.edfapg.sample.ui

import android.app.DatePickerDialog
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.children
import com.edfapg.sample.R
import com.edfapg.sample.app.EdfaPgTransactionStorage
import com.edfapg.sample.app.preattyPrint
import com.edfapg.sample.databinding.ActivitySaleBinding
import com.edfapg.sdk.core.EdfaPgSdk
import com.edfapg.sdk.model.request.card.EdfaPgTestCard
import com.edfapg.sdk.model.request.options.EdfaPgSaleOptions
import com.edfapg.sdk.model.request.order.EdfaPgSaleOrder
import com.edfapg.sdk.model.request.payer.EdfaPgPayer
import com.edfapg.sdk.model.request.payer.EdfaPgPayerOptions
import com.edfapg.sdk.model.response.base.error.EdfaPgError
import com.edfapg.sdk.model.response.sale.EdfaPgSaleCallback
import com.edfapg.sdk.model.response.sale.EdfaPgSaleResponse
import com.edfapg.sdk.model.response.sale.EdfaPgSaleResult
import io.kimo.lib.faker.Faker
import java.text.DecimalFormat
import java.util.*

class EdfaPgSaleActivity : AppCompatActivity(R.layout.activity_sale) {

    private lateinit var binding: ActivitySaleBinding
    private lateinit var edfapayTransactionStorage: EdfaPgTransactionStorage

    private val random = Random()

    private var payerBirthdate: Calendar? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        edfapayTransactionStorage = EdfaPgTransactionStorage(this)
        binding = ActivitySaleBinding.inflate(layoutInflater)
        setContentView(binding.root)

        configureView()
    }

    private fun configureView() {
        binding.btnClearTransactions.setOnClickListener {
            edfapayTransactionStorage.clearTransactions()
        }
        binding.btnRandomizeRequired.setOnClickListener {
            randomize(false)
        }
        binding.btnRandomizeAll.setOnClickListener {
            randomize(true)
        }
        binding.etxtPayerBirthdate.setOnClickListener {
            val nowCalendar = Calendar.getInstance()
            DatePickerDialog(
                this,
                { _, year, month, dayOfMonth ->
                    payerBirthdate = Calendar.getInstance()
                    payerBirthdate?.set(year, month, dayOfMonth)

                    binding.etxtPayerBirthdate.setText(payerBirthdate?.time.toString())
                },
                nowCalendar.get(Calendar.YEAR),
                nowCalendar.get(Calendar.MONTH),
                nowCalendar.get(Calendar.DAY_OF_MONTH)
            )
        }
        binding.btnAuth.setOnClickListener {
            executeRequest(true)
        }
        binding.btnSale.setOnClickListener {
            executeRequest(false)
        }
    }

    private fun randomize(isAll: Boolean) {
        binding.etxtOrderId.setText(UUID.randomUUID().toString())
        binding.etxtOrderAmount.setText(DecimalFormat("#.##").format(random.nextDouble() * 10_000).replace(",", "."))
        binding.etxtOrderDescription.setText(Faker.Lorem.sentences())
        binding.etxtOrderCurrencyCode.setText("SAR")

        binding.etxtPayerFirstName.setText(Faker.Name.firstName())
        binding.etxtPayerLastName.setText(Faker.Name.lastName())
        binding.etxtPayerAddress.setText(Faker.Address.secondaryAddress())
        binding.etxtPayerCountryCode.setText(Faker.Address.countryAbbreviation())
        binding.etxtPayerCity.setText(Faker.Address.city())
        binding.etxtPayerZip.setText(Faker.Address.zipCode())
        binding.etxtPayerEmail.setText(Faker.Internet.email())
        binding.etxtPayerPhone.setText(Faker.Phone.phoneWithAreaCode())
        binding.etxtPayerIpAddress.setText(
            "${random.nextInt(256)}.${random.nextInt(256)}.${random.nextInt(256)}.${random.nextInt(
                256
            )}"
        )

        binding.rgCard.check(binding.rgCard.children.toList().random().id)
        binding.txtResponse.text = ""

        if (isAll) {
            binding.etxtPayerMiddleName.setText(Faker.Name.lastName())
            binding.etxtPayerAddress2.setText(Faker.Address.streetWithNumber())
            binding.etxtPayerState.setText(Faker.Address.state())

            payerBirthdate?.set(1000 + random.nextInt(2000), random.nextInt(12), random.nextInt(31))
            binding.etxtPayerBirthdate.setText(payerBirthdate?.time.toString())

            binding.cbRecurringInit.isChecked = random.nextBoolean()
            binding.etxtChannelId.setText(UUID.randomUUID().toString().take(16))
        } else {
            binding.etxtPayerMiddleName.setText("")
            binding.etxtPayerAddress2.setText("")
            binding.etxtPayerState.setText("")
            binding.etxtPayerBirthdate.setText("")

            binding.cbRecurringInit.isChecked = false
            binding.etxtChannelId.setText("")
        }
    }

    private fun onRequestStart() {
        binding.progressBar.show()
        binding.txtResponse.text = ""
    }

    private fun onRequestFinish() {
        binding.progressBar.hide()
    }

    private fun executeRequest(isAuth: Boolean) {
        val amount = try {
            binding.etxtOrderAmount.text.toString().toDouble()
        } catch (e: Exception) {
            0.10
        }

        val order = EdfaPgSaleOrder(
            id = binding.etxtOrderId.text.toString(),
            amount = amount,
            currency = binding.etxtOrderCurrencyCode.text.toString(),
            description = binding.etxtOrderDescription.text.toString()
        )

        val card = when (binding.rgCard.checkedRadioButtonId) {
            R.id.rb_card_success -> EdfaPgTestCard.SALE_SUCCESS
            R.id.rb_card_failure -> EdfaPgTestCard.SALE_FAILURE
            R.id.rb_card_capture_failure -> EdfaPgTestCard.CAPTURE_FAILURE
            R.id.rb_card_3ds_success -> EdfaPgTestCard.SECURE_3D_SUCCESS
            R.id.rb_card_3ds_failure -> EdfaPgTestCard.SECURE_3D_FAILURE
            else -> EdfaPgTestCard.SALE_SUCCESS
        }

        val payerOptions = EdfaPgPayerOptions(
            middleName = binding.etxtPayerMiddleName.text.toString(),
            address2 = binding.etxtPayerAddress2.text.toString(),
            state = binding.etxtPayerState.text.toString(),
            birthdate = payerBirthdate?.time,
        )
        val payer = EdfaPgPayer(
            firstName = binding.etxtPayerFirstName.text.toString(),
            lastName = binding.etxtPayerLastName.text.toString(),
            address = binding.etxtPayerAddress.text.toString(),
            country = binding.etxtPayerCountryCode.text.toString(),
            city = binding.etxtPayerCity.text.toString(),
            zip = binding.etxtPayerZip.text.toString(),
            email = binding.etxtPayerEmail.text.toString(),
            phone = binding.etxtPayerPhone.text.toString(),
            ip = binding.etxtPayerIpAddress.text.toString(),
            options = payerOptions
        )

        val saleOptions = when (binding.cbRecurringInit.isChecked) {
            true -> EdfaPgSaleOptions(
                channelId = binding.etxtChannelId.text.toString(),
                recurringInit = binding.cbRecurringInit.isChecked
            )
            false -> null
        }

        val transaction = EdfaPgTransactionStorage.Transaction(
            payerEmail = payer.email,
            cardNumber = card.number
        )

        val termUrl3ds = "https://pay.edfapay.com/"

        onRequestStart()
        EdfaPgSdk.Adapter.SALE.execute(
            order = order,
            card = card,
            payer = payer,
            termUrl3ds = termUrl3ds,
            options = saleOptions,
            auth = isAuth,
            callback = object : EdfaPgSaleCallback {
                override fun onResponse(response: EdfaPgSaleResponse) {
                    super.onResponse(response)
                    onRequestFinish()
                    binding.txtResponse.text = response.preattyPrint()
                }

                override fun onResult(result: EdfaPgSaleResult) {

                    transaction.fill(result.result)
                    transaction.isAuth = isAuth

                    if (result is EdfaPgSaleResult.Recurring) {
                        transaction.recurringToken = result.result.recurringToken
                    } else if (result is EdfaPgSaleResult.Secure3d) {
                        EdfaPgRedirect3dsActivity.open(
                            this@EdfaPgSaleActivity,
                            result.result.redirectParams.termUrl,
                            result.result.redirectUrl,
                            result.result.redirectParams.paymentRequisites,
                            termUrl3ds
                        )
                    }

                    edfapayTransactionStorage.addTransaction(transaction)
                }

                override fun onError(error: EdfaPgError) = Unit

                override fun onFailure(throwable: Throwable) {
                    super.onFailure(throwable)
                    onRequestFinish()
                    binding.txtResponse.text = throwable.preattyPrint()
                }
            }
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (EdfaPgRedirect3dsActivity.isOk(requestCode, resultCode)) {
            Toast.makeText(this, "The 3ds operation has been completed.", Toast.LENGTH_SHORT).show()
        }
    }
}
