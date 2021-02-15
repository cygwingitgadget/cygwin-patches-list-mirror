Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id E04FB3861010
 for <cygwin-patches@cygwin.com>; Mon, 15 Feb 2021 10:43:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E04FB3861010
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1Yl9-1l98eK2Lz1-0036wA; Mon, 15 Feb 2021 11:43:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C136AA80D37; Mon, 15 Feb 2021 11:43:50 +0100 (CET)
Date: Mon, 15 Feb 2021 11:43:50 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] winsup/doc/posix.xml: add note for getrlimit, setrlimit, 
 links to notes
Message-ID: <20210215104350.GK4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Jon TURNEY <jon.turney@dronecode.org.uk>
References: <20210213010600.30473-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210213010600.30473-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:dBF8ninuTjXaT+sxByfjWa2rtKjmSil08FoEH6BS0wpsen5yWTC
 /yqHiUC9kkGThoQw0oq+IjZ2WNx3xCW6sXxVko4bh3YQI/QifyFDaS6rGuX9uaGGa3E9uuB
 hDGMAD7dQY0PpF9zhMF0h/YJYoWfy42x8EcJCiQneQpSbqLwerA1bgpK1LN1UGhqQuM4aZP
 lureMcsA8l+IScxFpf8Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WzSuWHJZO48=:dkJQfttv1VZzKwckvkmZ7M
 c5PYaARvlZecUbbiL/X4rFczXmgGeOq20WWIqw3LQp7KqRU37ZHWjQSDKJYPaYx/bKD86cqjo
 IMnWLBosnGY/7WfwgiKAdLHX67LpOc23GKvRN8Dz6vww3/4VDpJkaYsrPl72fl8Do77wGq137
 rGofaMfI3EhJw6hAO00E4aYTBVg1udgGkzvw97xDoQQikQu4NVZp2/Bhdd67uLihWlaWau+O5
 OqTaQ9wiWrPR3t9qUTFD6mUbd0wFcquFB+RvvG5xFfgbTo6IYevbOlOS77XHRaSLuUKkil5r7
 uFWhZN/JHH3DZNPSj+3Q5IVJjQD2XIEelqc/B+2Cgw+L58f2zNG6n8Etffy1pO6qvADmrBr08
 cJS8EwgMsVLvxk9aiSUAdnMqxOpj5KNSJR1JEcUl8JzSCxaqWoOX8PiGpHoTpbC0Fxn16L0HY
 IzBLzYnoCHSypImR34A6Bk0N1hAeiSqOrFHdA1UToog1Rx3K4Z2WG1oAvN6De5AlxiGZ9LSl1
 A==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 15 Feb 2021 10:44:00 -0000

Hi Brian,

On Feb 12 18:06, Brian Inglis wrote:
> 
> change notes to see "Implementation Notes" to links to std-notes.html;
> links work in html docs but appear as text in info docs;
> add link to std-notes.html to getrlimit, setrlimit;
> add note to document limitations of getrlimit, setrlimit resources support
> ---
>  winsup/doc/posix.xml | 101 ++++++++++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 44 deletions(-)
> 

Thanks for the patch, but...

> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index 0669d07de890..71f0373940a5 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -64,7 +64,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
>      atoi
>      atol
>      atoll
> -    basename			(see chapter "Implementation Notes")
> +    basename			<ulink url="std-notes.html">(see chapter "Implementation Notes")</ulink>

...please use xref rather than ulink for cross refs within the same
documentation,  i.e.

  (see <xref linkend="std-notes">chapter "Implementation Notes"</xref>)

Unfortunately I just noticed in both cases, that a matching link is
missing in cygwin-api.info afterwards.  However, cross referencing works
in cygwin-ug-net.info, afaics.

Jon, any idea why this is?  I don't see any difference in how the info
files are created.


Thanks,
Corinna
