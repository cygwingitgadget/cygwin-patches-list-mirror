Return-Path: <cygwin-patches-return-9575-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43252 invoked by alias); 26 Aug 2019 17:43:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 42986 invoked by uid 89); 26 Aug 2019 17:43:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham version=3.3.1 spammy=psd
X-HELO: NAM04-BN3-obe.outbound.protection.outlook.com
Received: from mail-eopbgr680102.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) (40.107.68.102) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 26 Aug 2019 17:43:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none; b=PxrUmPleiEiplja0Iptjz1gfzwIs6C6ekjtJFz+5UR2b6HYnAMqK1rwhLX6nYQ4jzrQLf/P0MMAERIvI6r/ItMss3pd4X/GkmEgH/eEKzUSJFQS1rTj/VAwka+kE+JZswLFJHqIGEE6u2Dmjge1SbyQ8z9GKROBIA0pW5WBYl4cMXw6aVRdkRGWVeS6EC8eMpC0rSoLcmmw+lJ5fKftKRjg4dHBYrZO+IP3osNv7LnjVf/9w1I7F/mjmHSYyEpM8Sb6f/L+ennuBnpH3mMkJVXudenz5OKQ6VnblPnNt73TyfZho7CQ9kQSXcJOVYhehrUYp9Weti227kgexT3qduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Rou1K0IOmeZE4hElYHqXzoRst8gpPo04YRGeHpAOVBE=; b=NYwfPPPi5QJmg8Zw14ZUjY1twquytfFkEb14waBxM6XVmO77tFq6dLKdTZWCgvVcM6QTGKuOrlKcDS0yCli7Qae7QG0extiRiedCS3k50nM0gxo/FGwxDpCGh83bkf7givOYprTtKtfQqa0h6of8aCy7qbV1MMcEkkuHHqmlDcx7hFBjYjCZUw8XljZiTpn8OM12vPR/4ePp8GGVJIYYOBVbvIPwWyOqflpe9XhTwy9lu6tA//T7cuT4kgXkKuiNr6JpmvbHfoNqZ1xRKUsUgzelr4JSGikqvdMd6WstuknIO6i4JA/k5QDUeyR12oT5gPL33CyOcvqmFuwQtv+fJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass smtp.mailfrom=cornell.edu; dmarc=pass action=none header.from=cornell.edu; dkim=pass header.d=cornell.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornell.edu; s=selector2; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck; bh=Rou1K0IOmeZE4hElYHqXzoRst8gpPo04YRGeHpAOVBE=; b=GMBs8ncChp46DC801+QOwOxy9EriHqHGDJ/OzQHTkTiw7//CW8m2TqbXn4d5zGOlkvO0BedBV0ZbgyVaedc7LxFANCzVNLhLraCN1B2sbBScJchmp5gZ9+/vIWxWW/AqB+4nAnHbV+wWouV5B81vZV3VP3mSz6dFRnrhrGiYkpw=
Received: from DM6PR04MB5738.namprd04.prod.outlook.com (20.179.51.81) by DM6PR04MB4028.namprd04.prod.outlook.com (20.176.87.28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Mon, 26 Aug 2019 17:43:46 +0000
Received: from DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473]) by DM6PR04MB5738.namprd04.prod.outlook.com ([fe80::998b:a76c:fc2b:1473%4]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019 17:43:46 +0000
From: Ken Brown <kbrown@cornell.edu>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: [PATCH] Cygwin: get_posix_access: avoid negative subscript
Date: Mon, 26 Aug 2019 17:43:00 -0000
Message-ID: <20190826174324.46043-1-kbrown@cornell.edu>
authentication-results: spf=none (sender IP is ) smtp.mailfrom=kbrown@cornell.edu;
x-ms-oob-tlc-oobclassifiers: OLM:457;
received-spf: None (protection.outlook.com: cornell.edu does not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1+URRHSty1m/iFRjtZQgjPyY2mZa7IhZ7uBomVCFFB2vElZ+xEGxOTiLH1JBMXBOl/mIfgyYwFfl2AP6AgilhQ==
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00095.txt.bz2

Don't refer to lacl[pos] unless we know that pos >=3D 0.
---
 winsup/cygwin/sec_acl.cc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/sec_acl.cc b/winsup/cygwin/sec_acl.cc
index 933bfa69d..67749d7b1 100644
--- a/winsup/cygwin/sec_acl.cc
+++ b/winsup/cygwin/sec_acl.cc
@@ -807,9 +807,9 @@ get_posix_access (PSECURITY_DESCRIPTOR psd,
 			  lacl[pos].a_id =3D ACL_UNDEFINED_ID;
 			  lacl[pos].a_perm =3D CYG_ACE_MASK_TO_POSIX (ace->Mask);
 			  aclsid[pos] =3D well_known_null_sid;
+			  has_class_perm =3D true;
+			  class_perm =3D lacl[pos].a_perm;
 			}
-		      has_class_perm =3D true;
-		      class_perm =3D lacl[pos].a_perm;
 		    }
 		  if (ace->Header.AceFlags & SUB_CONTAINERS_AND_OBJECTS_INHERIT)
 		    {
@@ -820,9 +820,9 @@ get_posix_access (PSECURITY_DESCRIPTOR psd,
 			  lacl[pos].a_id =3D ACL_UNDEFINED_ID;
 			  lacl[pos].a_perm =3D CYG_ACE_MASK_TO_POSIX (ace->Mask);
 			  aclsid[pos] =3D well_known_null_sid;
+			  has_def_class_perm =3D true;
+			  def_class_perm =3D lacl[pos].a_perm;
 			}
-		      has_def_class_perm =3D true;
-		      def_class_perm =3D lacl[pos].a_perm;
 		    }
 		}
 	    }
--=20
2.21.0
