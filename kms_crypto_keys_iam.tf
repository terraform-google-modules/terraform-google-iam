/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/******************************************
  Kms Crypto Key IAM binding authoritative
 *****************************************/
resource "google_kms_crypto_key_iam_binding" "kms_crypto_key_iam_authoritative" {
  for_each = {
    for binding in(local.kms_crypto_keys_authoritative_iam ? local.bindings_array : []) :
    binding => {
      crypto_key_id = element(split(" ", binding), 0)
      role          = element(split(" ", binding), 1)
      members       = compact(split(" ", element(split("=", binding), 1)))
    }
  }

  crypto_key_id = each.value.crypto_key_id
  role          = each.value.role
  members       = each.value.members
}

/******************************************
  Kms Crypto Key IAM binding additive
 *****************************************/
resource "google_kms_crypto_key_iam_member" "kms_crypto_key_iam_additive" {
  for_each = {
    for binding in(local.kms_crypto_keys_additive_iam ? local.bindings_array : []) :
    binding => {
      crypto_key_id = element(split(" ", binding), 0)
      member        = element(split(" ", binding), 1)
      role          = element(split(" ", binding), 2)
    }
  }

  crypto_key_id = each.value.crypto_key_id
  member        = each.value.member
  role          = each.value.role
}
