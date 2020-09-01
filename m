Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by sourceware.org (Postfix) with ESMTPS id 9AF853959E61
 for <cygwin-patches@cygwin.com>; Tue,  1 Sep 2020 19:50:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9AF853959E61
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=johannes.schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598989801;
 bh=eKCyyzVTSNNUQ3s+oxahS7/p5vKOK5rVFYgB0k3hDGk=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=MyUfo+1P3SlBJ85KFH6V+cGoLl6bcCaOEuZ295oCpQYApt9maAEDq8ocjo+rjZUSG
 h5vRE9bDJlMxFjoQcdHumx6UUybX5vkOD7ejrY3DZH3DXp+9GGkP/nkSW2/suyKVhP
 WHN6teacJKltpMAXhSdcGrRrqE5u5pQTymDkQARw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.214.118]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MD9T7-1kMEhM0au1-00956F for
 <cygwin-patches@cygwin.com>; Tue, 01 Sep 2020 21:50:01 +0200
Date: Tue, 1 Sep 2020 18:18:51 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] fhandler_pty_slave::setup_locale: fall back to UTF-8,
 not ASCII
Message-ID: <nycvar.QRO.7.76.6.2009011818350.56@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wq0hsGxPaxYTeh6bBt+9rTP5D/37xmCMc/KP/yoNqrIfr28Vr+E
 hlBoL4MM6G6ST5Im4UYHC1FlMZsNJojJlaTXMf49CT62i9JJA+Nyj4t8k2bo89ZcW9VYBG9
 imxYQ77wKYuJkpE/oiiE9MLD/aA14y6uqOKtixxkajw1O3hK7iK0zood8rdK3W9r/EdwPuU
 ZRipABdvBPtaO7hNkaxfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ulyk7gHm1hU=:R2dti52wP3R2ys62wb5bsJ
 OUNTzZUKwdXZNfdzWxB0jD/t7JwRs8nNuG1OI5SWCk659Eb2Zv6frX/geLqWGRny9utuyPhx2
 i8g9ZmghQA23GmgMY1/iwYVPPu4iwIqx19fVxhT7kYh1fboA8BECHsF+7IbmVphoLJWoq33af
 teJ9tB9OIAi0E6qJSsFZY7Km+iD3nWSN9INizYaAoau32UghVSg0w7pP9uyYOuv8tzvuK+mTj
 pUx9YWl16V/JAOrIYQbhGdR6Fw4XynWqJWKwH8S53no2ZouTgvLKgEaFnX5/WOHlZAAMjwBfI
 QYAfvAZsBoUBwKB112GZTTc9kCCoGKq4h5ljDGog+vJ32dF8RajCn+SUp7DZorVwp0gjMJKop
 y0zUEUkdt3Y57mU8qdAyA46hJFMx0aqlhH+sA9eTtXksA8m3yTBAolQrnyewb2HRYvjhJpOiN
 5tRCO4XFqTeot4xYu9LCqhutrcXunRJZ5rmAPKDHFtYyZbgV2V7zSa81tpNFGSeS/ALlyCL5Y
 WVs9zyz7Zn2Tn40LrBB4xVBrXq5VsefUHE5cJtex0THgJF/GlkUVUOpMeebcrRFgs5bls/N+f
 1URYBw2YFent+vq7q5/oohjYQMcOm4K8Jt9KoA5EDqE2Lmb9tosj6ZgZqccDf8G/01a3Jl8az
 wdOiX9G2VrJJYsKNFWHFU+wS663ZU6pBAOMmPZJtzerMrLA5M9jTuAtfUrirAQfqkvXnixZlc
 /e7gDKLmObiBQfOr7gMS9aKiSV1WEQ36hIuZBE+3Lw27aANF+0pnLJ6yVrUrGAsVricB8yv72
 ZZbk1CsKW87D9ygYaRT1x4XJKjxrJytuKPpksWbk3TwtVtWZcLSgplcUxbCHSMIen2XC7dgnN
 5/rbarYWWbsZHpLkRL6bjlejb+cVacvVD9u/QsjIUKnGynwK92UTg0Ry+ht9z6eaFIn78BQuB
 Tx4WF2K9UtdX8ze8XIOMR8r+gf1LbnUr0FzcSx9d2Y7Fc7a3OVRDsLhnKaIr1t/ibNmAMQ1IU
 LPsgAymgLu0Ljz9ho7EUw9m4Sjua9GqFM+c2I6fyjj0lF3pZaf808glsXbjwvr3uM5SjNuh5l
 y973FgRTd9fkCvsd5/XkGjZ+jw7pHBodD/9VWFFfq7gcPH1f7DLcVizaTkH7GLlI4ZdCs4jfo
 xv+Nx0tCh2y/WJOHutKP8ZOlj1nLTph2MNOwbP11gWzXQjSNmmBmaYkY9nAQU5QR814CQe19e
 QjOkxOJvcXEqoiH6BwpeMJrtsZRvDylcMYKMZfg==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, DATE_IN_PAST_03_06,
 DKIM_SIGNED, DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 01 Sep 2020 19:50:05 -0000

When we fail to determine the Console output code page to use in the
Pseudo Console, we used to fall back to ASCII.

However, a much better fall-back code page is UTF-8 because that's what
Cygwin defaults to, internally, when no encoding was specified.

Besides, `/etc/profile.d/lang.sh` essentially sets `LANG=3D$(locale -uU)`
(where the `-U` says that `.UTF-8` should be appended). Meaning: we
_really_ want to use the UTF-8 code page.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/fhandler_tty.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b3458595a..06789a500 100644
=2D-- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2864,11 +2864,11 @@ fhandler_pty_slave::setup_locale (void)
     {
       UINT code_page;
       if (lcid =3D=3D 0 || lcid =3D=3D (LCID) -1)
-	code_page =3D 20127; /* ASCII */
+	code_page =3D CP_UTF8; /* Cygwin prefers UTF-8 */
       else if (!GetLocaleInfo (lcid,
 			       LOCALE_IDEFAULTCODEPAGE | LOCALE_RETURN_NUMBER,
 			       (char *) &code_page, sizeof (code_page)))
-	code_page =3D 20127; /* ASCII */
+	code_page =3D CP_UTF8; /* Cygwin prefers UTF-8 */
       SetConsoleCP (code_page);
       SetConsoleOutputCP (code_page);
     }
=2D-
2.27.0

