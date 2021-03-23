Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id B0D66385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 15:58:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0D66385BF9E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0X4c-1ldE0Q1X5Y-00wStM for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 16:58:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 033E8A80DBA; Tue, 23 Mar 2021 16:58:54 +0100 (CET)
Date: Tue, 23 Mar 2021 16:58:53 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] Handle "app execution aliases"
Message-ID: <YFoQPRMwf1RYBufS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
 <cover.1616428114.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1616428114.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:7MvFmaIIr+ImaEKALGA8Fs8cqVWuc/Z+UTWhMQAfvO18A3zFUsv
 /EBG9g4x3syPKWLdgzH+3YmCC0bs+gQ72Dopnr2oEMjrgSztFayCn1gL7C4wHST36c9PP2s
 ZjC/5xr9aawFu3WF1afcCDk/kYnKtPz9Bo3m4p0ETwMgKcVmY3m8BRSZz5Kcb/LJ502RhIL
 ZXTq008trMeh+JME71xRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R1MqZC1ItwU=:2Q275vV7AHgPflJfp3x9XO
 29nGrsOrDqf+4jM1UGOK8XHE4Kjt6TyYcik8vI5ml8lbcw5tD+Z8dTDUvM5K70F4P+6Dnp8s3
 lTNdfqSYF/TU3VZFddNF/ntzp/SktRbsw3qotABDzE8BhojLmqqmuvB1en59CIdLrM6fdcLuI
 SneYJWVYOCPWWJjaxpmbDAkwFYRXXCJu7B/ZZKPzdwhrErHj7BTzdZWAX0MaqSuurLJBn60xm
 DWp1yDS1FPYNHJt5DODcKK4pntJULDc+zshuPZ4+yNnrNRHjUpGpvHqLn/eFlOnXyKeCEHLBt
 j/5NYEmyL/7/6vQlPcPj9qRzWpoKv4sa/le/40JKw1j4xqeKsF6fvTIH94qVz9old1CyI0lH0
 hRNhnXZ6BL8zXn/4BQyWUzMKXmqmesjkQemCNzO5c2Bu84H5t0AazSg3TZJ/HWy6sckh53yI9
 5vvuBiC/zQ==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 23 Mar 2021 15:58:57 -0000

On Mar 22 16:51, Johannes Schindelin via Cygwin-patches wrote:
> When installing e.g. Python via the Windows Store, it is common that the
> `python3.exe` entry in the `PATH` is not actually an executable at all,
> but an "app executaion alias" (i.e. a special class of reparse point).
> 
> These filesystem entries are presented as 0-size files, but they are not
> readable, which is why Cygwin has problems to execute them, with the error
> message "Permission denied".
> 
> This issue has been reported a couple of times in the Git for Windows and
> in the MSYS2 project, and even in Cygwin
> (https://cygwin.com/pipermail/cygwin/2020-May/244969.html, the thread
> devolved into a discussion about Thunderbird vs Outlook before long,
> though).
> 
> The second patch fixes that, and for good measure, the first patch teaches
> Cygwin to treat these reparse points as symbolic links.
> 
> Changes since v1:
> 
> - Introduce and use `struct _REPARSE_APPEXECLINK_BUFFER`.
> 
> Johannes Schindelin (2):
>   Treat Windows Store's "app execution aliases" as symbolic links
>   Allow executing Windows Store's "app execution aliases"
> 
>  winsup/cygwin/path.cc  | 40 ++++++++++++++++++++++++++++++++++++++++
>  winsup/cygwin/spawn.cc |  7 +++++++
>  2 files changed, 47 insertions(+)

I decided to apply this now, while we're still discussing the osf handle
problem.

Pushed with two fixes.  I prepended "Cygwin:" to the git log subject and
I patched this compile time problem:

  path.cc: In function ‘int check_reparse_point_target(HANDLE, bool, PREPARSE_DATA_BUFFER, PUNICODE_STRING)’:
  path.cc:2581:25: error: ‘struct _REPARSE_APPEXECLINK_BUFFER’ has no member named ‘Strings’
   2581 |       WCHAR *buf = rpl->Strings;
	|                         ^~~~~~~

I also added this to the release notes.


Thanks,
Corinna
