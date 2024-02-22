import 'package:hele/core/constants/image_constant.dart';

class Article {
  final String title;
  final String subtitle;
  final String image;
  final String sumber;

  const Article({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.sumber,
  });
}

List<Article> informasi = const [
  Article(
    title: 'Pengertian Limbah B3 dan Bagaimana Cara Mengendalikannya',
    subtitle: 'universaleco',
    image: ImageConstant.articleImage1,
    sumber:
        'https://environment-indonesia.com/articles/pengertian-limbah-b3-dan-bagaimana-cara-mengendalikannya/',
  ),
  Article(
    title: 'Sampah B3 Dalam Kehidupan Sehari-Hari',
    subtitle: 'universaleco',
    image: ImageConstant.articleImage2,
    sumber:
        'https://www.universaleco.id/blog/detail/sampah-b3-dalam-kehidupan-sehari-hari/168',
  ),
  Article(
    title: 'Kode Limbah B3 – Penjelasan dan Penamaan',
    subtitle: 'universaleco',
    image: ImageConstant.articleImage3,
    sumber:
        'https://www.universaleco.id/blog/detail/kode-limbah-b3-penjelasan-dan-penamaan/370',
  ),
  Article(
    title: 'Pengemasan Limbah B3 Berdasarkan Jenis Fase',
    subtitle: 'universaleco',
    image: ImageConstant.articleImage4,
    sumber:
        'https://www.universaleco.id/blog/detail/pengemasan-limbah-b3-berdasarkan-jenis-fase/389',
  ),
  Article(
    title: 'Pengelolaan Sampah di Negara Lain yang Patut Dicontoh',
    subtitle: 'universaleco',
    image: ImageConstant.articleImage5,
    sumber:
        'https://www.universaleco.id/blog/detail/pengelolaan-sampah-di-negara-lain-yang-patut-dicontoh/374',
  ),
  Article(
    title: 'Kerajinan Dari Botol Plastik Bekas',
    subtitle: 'universaleco',
    image: 'assets/images/artikel6.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/kerajinan-dari-botol-plastik-bekas/342',
  ),
  Article(
    title: 'Sistem Tanggap Darurat Pengelolaan Limbah B3',
    subtitle: 'universaleco',
    image: 'assets/images/artkel7.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/sistem-tanggap-darurat-pengelolaan-limbah-b3/324',
  ),
  Article(
    title: 'Prinsip 3R (Reduce, Reuse, dan Recycle) Dalam Pengolahan Sampah',
    subtitle: 'universaleco',
    image: 'assets/images/artkel8.jpg',
    sumber:
        'https://www.universaleco.id/blog/detail/prinsip-3r-reduce-reuse-dan-recycle/156',
  ),
];
