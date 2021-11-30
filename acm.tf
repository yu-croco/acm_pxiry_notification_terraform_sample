locals {
  # 登録などは手動のため、一旦local変数で管理している。
  acms = {
    data_estie_co_jp = {
      domain = "data.estie.co.jp"
      type   = "AMAZON_ISSUED"
    }
    estie_jp = {
      domain = "estie.jp"
      type   = "AMAZON_ISSUED"
    }
    leasing_estiepro_jp = {
      domain = "leasing.estiepro.jp"
      type   = "AMAZON_ISSUED"
    }
    staging_estie_co_jp = {
      domain = "staging.estie.co.jp"
      type   = "AMAZON_ISSUED"
    }
    client1_domain_tld = {
      domain = "client1.domain.tld"
      type   = "IMPORTED"
    }
    server = {
      domain = "server"
      type   = "IMPORTED"
    }
    www_estie_co_jp = {
      domain = "www.estie.co.jp"
      type   = "AMAZON_ISSUED"
    }
  }
}

data "aws_acm_certificate" "this" {
  for_each = local.acms
  domain   = each.value.domain
  types    = [each.value.type]
}
