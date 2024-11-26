import 'package:dma_inc/consts/consts.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: dmaDarkGrey,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Introduction"),
            _sectionBody(
                "Dragon Martial Arts strives to provide an easy-to-use site with accurate content, "
                "product information, policies, pricing, and visual displays. Policies, pricing, "
                "and item availability are subject to change without notice, and we reserve the right "
                "to limit quantities. Prices displayed on our site are subject to final approval at the "
                "time of order fulfillment."),
            _sectionTitle("Usage and Liability"),
            _sectionBody(
                "The user expressly agrees that the use of the Dragon Martial Arts website is at the "
                "user’s sole risk. This site is provided on an 'AS IS' and 'AS AVAILABLE' basis. Dragon Martial Arts "
                "makes no warranties, express or implied, regarding the site's operation, content, or products. "
                "Dragon Martial Arts will not be liable for any damages arising from the use of this site."),
            _sectionTitle("Usage by Minors"),
            _sectionBody(
                "Dragon Martial Arts cannot prohibit minors from visiting this site. Parents and guardians "
                "are responsible for supervising children under 18 and ensuring appropriate use. Certain products "
                "require the buyer to be 18 years of age or older."),
            _sectionTitle("Applicable Law"),
            _sectionBody(
                "This site is created and controlled by Dragon Martial Arts in Texas, and the laws of Texas "
                "govern these terms. Users consent to the exclusive jurisdiction of Texas courts for any litigation "
                "arising from the use of the site."),
            _sectionTitle("Severability"),
            _sectionBody(
                "If any provision of these Terms of Use is found to be invalid or unenforceable, it will not affect "
                "the remaining provisions, which shall remain valid and enforceable."),
            _sectionTitle("Shipping"),
            _sectionBody(
                "Shipping prices are set by the courier and determined by the weight and size of the package. "
                "Oversized packaging may incur additional costs. A \$3.00 handling fee is charged on every order. "
                "Orders are usually shipped within 24 hours. Customers are responsible for ensuring the accuracy of "
                "the shipping address."),
            _sectionTitle("Returns and Refunds"),
            _sectionBody(
                "Non-damaged items may be returned within 7 days for a full refund. A 15% restocking fee applies to "
                "returns made after 7 days. Returns must include an RMA number and the original packaging. Refunds and "
                "exchanges are subject to approval by the quality control division."),
            _sectionTitle("Liability Waiver"),
            _sectionBody(
                "By purchasing any item, the buyer assumes responsibility for compliance with all applicable laws. "
                "DMA-Inc is not responsible for improper use or violations of the law by the buyer. The buyer agrees to "
                "indemnify DMA-Inc for any claims resulting from the purchase, ownership, or use of the items."),
            const SizedBox(height: 20),
            const SizedBox(height: 16),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () => Navigator.of(context).pop(),
            //     child: "Close".text.size(12).color(dmaWhite).make(),
            //   ),
            // ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(dmaRed),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the menu
                },
                child: Text(
                  "Close",
                  style: TextStyle(color: dmaWhite, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: dmaRed),
      ),
    );
  }

  Widget _sectionBody(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14, color: dmaWhite),
      ),
    );
  }
}
