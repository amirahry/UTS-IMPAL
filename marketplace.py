"""Soal 2.C: kerangka kelas marketplace, tanpa logika bisnis."""
from decimal import Decimal


class Merchant:
    """Menyediakan rekening merchant dan memverifikasi transfer."""
    def __init__(self):
        self._id_merchant: int = 0
        self._nama: str = ""
        self._rekening: str = ""

    def getMerchantAccount(self) -> str:
        pass

    def verifyTransfer(self) -> bool:
        pass


class Produk:
    """Menyimpan informasi dan harga produk."""
    def __init__(self):
        self._id_produk: int = 0
        self._nama: str = ""
        self._harga: Decimal = Decimal("0")
        self._stok: int = 0

    def getPrice(self, id: int) -> Decimal:
        pass


class OrderDetail:
    """Menyimpan rincian barang dan menghitung subtotal."""
    def __init__(self):
        self._id_detail: int = 0
        self._produk: Produk | None = None
        self._quantity: int = 0
        self._harga_satuan: Decimal = Decimal("0")

    def create(self) -> None:
        pass

    def setId(self, id: int) -> None:
        pass

    def setQuantity(self, id: int, qty: int) -> None:
        pass

    def subTotal(self) -> Decimal:
        pass


class Pembayaran:
    """Menangani transfer dan pembuatan bukti pembayaran."""
    def __init__(self):
        self._id_pembayaran: int = 0
        self._total: Decimal = Decimal("0")
        self._rekening_tujuan: str = ""
        self._status: str = "menunggu"
        self._bukti_pembayaran: str = ""

    def transfer(self, totalAmount: Decimal, merchantAccount: str) -> None:
        pass

    def generatePaymentProof(self) -> str:
        pass


class EmailService:
    """Mengirim dokumen pesanan dan kuitansi melalui email."""
    def sendOrderPdfAndReceipt(self, email: str) -> None:
        pass


class Order:
    """Mengelola detail, total pesanan, dan penyelesaian checkout."""
    def __init__(self):
        self._id_order: int = 0
        self._email_pembeli: str = ""
        self._merchant: Merchant | None = None
        self._details: list[OrderDetail] = []
        self._pembayaran: Pembayaran | None = None
        self._email_service: EmailService | None = None
        self._total: Decimal = Decimal("0")
        self._status: str = "baru"

    def create(self) -> None:
        pass

    def tambahDetail(self, detail: OrderDetail) -> None:
        pass

    def calculateTotal(self) -> Decimal:
        pass

    def checkoutAndComplete(self) -> None:
        pass
