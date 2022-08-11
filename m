Return-Path: <corinna@vinschen.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 7A0683858283
 for <cygwin-patches@cygwin.com>; Thu, 11 Aug 2022 17:35:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A0683858283
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=vinschen.de
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=vinschen.de
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhWx1-1nizaw3rO7-00efxF for <cygwin-patches@cygwin.com>; Thu, 11 Aug 2022
 19:35:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 60B69A80B75; Thu, 11 Aug 2022 19:35:33 +0200 (CEST)
From: Corinna Vinschen <corinna@vinschen.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] newlocale: fix crash when trying to write to __C_locale
Date: Thu, 11 Aug 2022 19:35:33 +0200
Message-Id: <20220811173533.295266-1-corinna@vinschen.de>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o/nNM6wkkIfUueprMcHEFvRfSNklc9BjJLmwFn+CK2/tjyiJD/S
 kYt+NJBtJ/DqckUQRupepxWJgYHpDxswllatn+RXIQZftAEy6EhQbyUgS4eJBbLjKze3iVv
 GlnOBAqOhyNgff68r/zasSR0rNQpeGzPaSlmsRzi4NGyT/HKAKf9N2Ibwt0dHJmXCR3+h1d
 aAs6z1Toc7qm1Tz8WYWUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KR8n7ChYTYg=:4RV7J5uDvre+zRDsBPQghP
 mcuoHPGr/h9e/NKPK7cGmYzx1mWOUxVfodLvfq8bpW82XTnRtb+eYI6vgt1rKQUm/8TZkmwCj
 f6qPQqRU84er2VKmDAhd144aulqOa/VqHr0nBiKDEDUjXMnGjapaYbn+1KqimkQ3ruTYe4lVC
 fyIt9bZoBmcPoe2SCjeUfKuLjiIIsMhdJyo+GZaWs6TdOAdyrUohtI0/DaS1lLdzhmVC3Xd9P
 12Do4y0whS+sTCjqQNW4qESK5tktc998IytsarRZ/5Gqwe55vgZtZwRzTkzBfTqUDj4biNgKg
 U7xLLKhvC1jeOPgrPCfmbcshs+obQHNIZ112zN6u40MwLSUBF/+GHqM72Gz4q/YmNDFbDzCwS
 uB/+RWrD2bzL1ZecrV9MynGPg4r2HiHlQUVdESoFODlOKt6cjuVQsDYM6m8BDusZPXTZE7Al6
 ej8TuLwj/BadN6icef18rFyDBeiDfseNIv1Is8JKOa9QR1WV01JOrmsVVDqrAIxk4bIryQkVo
 QOWwfBBlPZ8qcCHRDwifXAtS1yOq4QQGUBT3Y1u4Ju28V2/H/PHTncDSOO+ElENzC0Vb/jOy5
 jggYOehNtlBEOEoIHgSK0/anPgonabiy4VuOHLrE9o++dspYdL8VPavNEAlfhZ8Rm9AqGwtEO
 7W7ZZh0DVacURWb+tamuFEUvD23kMI8ADs1BqHjlxy3+OLyM5/YEOLV6zgj2uS0GMXgEhvxhF
 G9mcFnDh6jX9j2cVy4k815PInu43p6ynFu4zEA==
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 11 Aug 2022 17:35:38 -0000

This simple testcase:

  locale_t st = newlocale(LC_ALL_MASK, "C", (locale_t)0);
  locale_t st2 = newlocale(LC_CTYPE_MASK, "en_US.UTF-8", st);

is sufficient to reproduce a crash in _newlocale_r.  After the first call
to newlocale, `st' points to __C_locale, which is const.  When using `st'
as locale base in the second call, _newlocale_r tries to set pointers
inside base to NULL.  This is bad if base is __C_locale, obviously.

Add a test to avoid trying to overwrite pointer values inside base if
base is __C_locale.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 newlib/libc/locale/newlocale.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/newlib/libc/locale/newlocale.c b/newlib/libc/locale/newlocale.c
index 0789d5fd95ec..08f29dbcc0c1 100644
--- a/newlib/libc/locale/newlocale.c
+++ b/newlib/libc/locale/newlocale.c
@@ -188,7 +188,8 @@ _newlocale_r (struct _reent *p, int category_mask, const char *locale,
 	if (tmp_locale.lc_cat[i].buf == (const void *) -1)
 	  {
 	    tmp_locale.lc_cat[i].buf = base->lc_cat[i].buf;
-	    base->lc_cat[i].ptr = base->lc_cat[i].buf = NULL;
+	    if (base != __get_C_locale ())
+	      base->lc_cat[i].ptr = base->lc_cat[i].buf = NULL;
 	  }
 #endif /* __HAVE_LOCALE_INFO__ */
       _freelocale_r (p, base);
-- 
2.37.1

