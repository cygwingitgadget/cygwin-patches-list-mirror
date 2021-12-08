Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id DC0513858D28
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 08:19:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org DC0513858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from Express5800-S70 (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 1B88JTUG021867
 for <cygwin-patches@cygwin.com>; Wed, 8 Dec 2021 17:19:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1B88JTUG021867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1638951570;
 bh=zgEFgsQbU3kfIed7RbRfHasY2HgzbtDT22wfxZt+JSo=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=e+I6nZ2sa3k+60e5KmHKt1fcdnmAWUfCJ00+PvXNNbUWtAK2wOQ+TX3yAvt9196y0
 hstQ8dpvzBHRV6gPft37Zow9y5aRCQ8kpytASQkAZR4WVUhAUNcZRnQjPiNBFUoZLv
 jYF6D5SjQGKMlm11kVnHN/Rrzv8mE/0rH7q5h7Mu30QSFApIXxwnx4hmB5qO/Ni61t
 oNLeB8t34c/Q77npGqBGqrR+Ggw3E/eRtPOv8ShkBYEUqcLDosGrnMgmK1cWywUS3Z
 W0KgxZeeMY7ueKB7C+HaHlknTnvYlXqwhYRas4O2TwE67eq6XqeOHwQDokT5JNmYgc
 b2lMDwIDjxP5A==
X-Nifty-SrcIP: [110.4.221.123]
Date: Wed, 8 Dec 2021 17:19:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
Message-Id: <20211208171929.68490866d4a07aac4b1ca0d7@nifty.ne.jp>
In-Reply-To: <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
 <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
 <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
 <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, BODY_8BITS,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 08 Dec 2021 08:19:50 -0000

On Tue, 7 Dec 2021 22:30:44 -0800
Mark Geisert wrote:
> Brian Inglis wrote:
> > On 2021-12-07 13:18, Thomas Wolff wrote:
> >>
> >> Am 07.12.2021 um 15:23 schrieb Corinna Vinschen:
> >>> On Dec  7 23:00, Takashi Yano wrote:
> >>>> - Fix a bug in fhandler_dev_clipboard::read() that the second read
> >>>>    fails with 'Bad address'.
> >>>>
> >>>> Addresses:
> >>>>    https://cygwin.com/pipermail/cygwin/2021-December/250141.html
> >>>> ---
> >>>>   winsup/cygwin/fhandler_clipboard.cc | 2 +-
> >>>>   winsup/cygwin/release/3.3.4         | 6 ++++++
> >>>>   2 files changed, 7 insertions(+), 1 deletion(-)
> >>>>   create mode 100644 winsup/cygwin/release/3.3.4
> >>>>
> >>>> diff --git a/winsup/cygwin/fhandler_clipboard.cc 
> >>>> b/winsup/cygwin/fhandler_clipboard.cc
> >>>> index 0b87dd352..ae10228a7 100644
> >>>> --- a/winsup/cygwin/fhandler_clipboard.cc
> >>>> +++ b/winsup/cygwin/fhandler_clipboard.cc
> >>>> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
> >>>>         if (pos < (off_t) clipbuf->cb_size)
> >>>>       {
> >>>>         ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> >>>> -      memcpy (ptr, &clipbuf[1] + pos , ret);
> >>>> +      memcpy (ptr, (char *) &clipbuf[1] + pos, ret);
> > 
> >>> I'm always cringing a bit when I see this kind of expression. Personally
> >>> I think (ptr + offset) is easier to read than &ptr[offset], but of course
> >>> that's just me.  If you agree, would it be ok to change the above to
> >>>
> >>>    (char *) (clipbuf + 1)
> >>>
> >>> while you're at it?  If you like the ampersand expression more, it's ok,
> >>> too, of course.  Please push.
> > 
> >> In this specific case I think it's actually more confusing because of the type 
> >> mangling that's intended in the clipbuf.
> >> At quick glance, it looks a bit as if the following were meant:
> >>
> >>    (char *) clipbuf + 1
> >>
> >> I'd even make it clearer like
> >>
> >> +      memcpy (ptr, ((char *) &clipbuf[1]) + pos, ret);
> >> or even
> >> +      memcpy (ptr, ((char *) (&clipbuf[1])) + pos, ret);
> > 
> > If the intent is to address:
> > 
> >      clipbuf + pos + 1
> > 
> > use either that or:
> > 
> >      &clipbuf[pos + 1]
> > 
> > to avoid obscuring the intent,
> > and add comments to make it clearer!
> 
> Boy am I kicking myself for screwing up the original here and opening this can of 
> worms.  Brian, you'd be correct if clipbuf was (char *) like anything-buf often 
> is.  But here it's a struct defining the initial part of a dynamic char buffer.
> 
> So my original
>      &clipbuf[1]
> to mean "just after the defining struct" was OK.  But the code needed a ptr to 
> some char offset after that and
>      &clipbuf[1] + pos
> was wrong.  Casting the left term to (char *) would fix it.  But I like Corinna's 
> choice of
>      (char *) (clipbuf + 1)
> to be most elegant and clear of all.  Now enclose that in parens and append the 
> char offset so the new expression is
>      ((char *) (clipbuf + 1)) + pos
> and all should be golden.  I don't think extra commentary is needed in code.
> 
> (I think.)

I think the following patch makes the intent clearer.
What do you think?


From d0aee9af225384a24ac6301f987ce2e94f262500 Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Wed, 8 Dec 2021 17:06:03 +0900
Subject: [PATCH] Cygwin: clipboard: Make intent of the code clearer.

---
 winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
 winsup/cygwin/include/sys/clipboard.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
index 05f54ffb3..65a3cad97 100644
--- a/winsup/cygwin/fhandler_clipboard.cc
+++ b/winsup/cygwin/fhandler_clipboard.cc
@@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
       clipbuf->cb_sec  = clipbuf->ts.tv_sec;
 #endif
       clipbuf->cb_size = len;
-      memcpy (&clipbuf[1], buf, len); // append user-supplied data
+      memcpy (clipbuf->data, buf, len); // append user-supplied data
 
       GlobalUnlock (hmem);
       EmptyClipboard ();
@@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
       if (pos < (off_t) clipbuf->cb_size)
 	{
 	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
-	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
+	  memcpy (ptr, clipbuf->data + pos, ret);
 	  pos += ret;
 	}
     }
diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
index 4c00c8ea1..b2544be85 100644
--- a/winsup/cygwin/include/sys/clipboard.h
+++ b/winsup/cygwin/include/sys/clipboard.h
@@ -44,6 +44,7 @@ typedef struct
     };
   };
   uint64_t      cb_size; // 8 bytes everywhere
+  char          data[];
 } cygcb_t;
 
 #endif
-- 
2.34.1


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
