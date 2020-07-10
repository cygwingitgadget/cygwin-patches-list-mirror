Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 59A5B384B806
 for <cygwin-patches@cygwin.com>; Fri, 10 Jul 2020 08:35:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 59A5B384B806
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeCxj-1kV5893y2p-00bJY1; Fri, 10 Jul 2020 10:35:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 17A8FA80B92; Fri, 10 Jul 2020 10:35:30 +0200 (CEST)
Date: Fri, 10 Jul 2020 10:35:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Clarify FAQ 1.5 What version of Cygwin is this,
 anyway? Relate Cygwin DLL to Unix kernel, add required options to command
 examples, differentiate Unix and Cygwin commands; mention that the cygwin
 package contains the DLL.
Message-ID: <20200710083530.GE514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,
 cygwin-patches@cygwin.com
References: <20200710011544.28272-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200710011544.28272-2-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710011544.28272-2-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:NkEsvYaRg0i7hItR9EWvdPknHLpYD5gqJUVUzfbuDDIRcOdxk1m
 Ip6s/zHHxaxSb7qMNfFbbFK+MWwWRPo3nkn9bK+T7P4Cg7QQ1xJwiyAQJNnzFxjryMlpux5
 Mn4gWsQaMein0PTuLGsvm++S2Xxkj2Gq5KQLFZgjfMFtOhMrpBmnnb8HhreeG0g5qI3EcS3
 z8rOPEbDf8d5GsvV2Uz+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bSMWfvHC+CE=:R3RQB37oLf+zUrTFv84Xn7
 s+MsGmgs52fUvzAoBsIQKIYEaOIYYaGhdg0/ZZTNgm6lSFEvSL8wP/UBsZfN7U9b0DHt2JU0X
 xYtVKvJMbBHXtgcd5w1OFODUACsAg0RLxrwp+xpGj/dCqj9F1uQBnSkR5eiR7h+D0nNua3t70
 2wQOG99NXQaQkpgYScLHdpcUmf94qFnFzV45758WHyR+LabBAn6ZQdRfHlWbky1s/3a1YUyO/
 7PRsJZeFAfz3ikoQ99AfQfW7WhRYyURvNOgxmHVNBz8AkQWP0GYWODr11iQtfFzwk8D1BCtiA
 /piC5UuFjWKlHm+mTEnLVqd8hhy9zgEClYTLzyKH4Xe2qMbDWa3f2GS09nZoOtCdr/gJGyRcq
 8zYmmscWsttqVePDZSnBNkewkDAjgP2LQ611VIB7wEaarNoxiOj4u5Rg2/AmrmBxSbs0cnUpm
 20cBvg+niJyLirlm3eAgNxhhHYDm0kI+syHnLbZQBRroAQk7CuR2y6V7jFo+6Q5xuMcSYsX5g
 Yy8aSVTmQpwDtFlwyCVADPWj6LPGaCt4sSFr8rm9LMRMPYNFUrXQomdzFPSYl2+HmxtlaDmJZ
 41jFbhRJIOUrKEKxFM5J7MyNQegUvlaYxAyfiu6utCcbIXcDhguVVXB3CHO3TBdzSewxed7AC
 11cbQEhbhOVfzAFuRIUmw1HqEhTcyXz8x3tm3SSemx/EQ7zbc+J/eQKyv0nQW5bpU7H6Phx4z
 m2tMdfwaHZIDVgjTVY/IG6Z22h3bnSxfZiPbvqTS8ZfFjJi1wZQcFO8SfkD9sq1dJAm7fL9vE
 56wr2ABpZooIKjZBgVwhOlPybRRjZ87EE5+OUrujn1TkRKJxfQ0SzVgAxDJdtZthNwl0ZRXcu
 qGJQMzlB7kJ/szQzfOMg==
X-Spam-Status: No, score=-103.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 10 Jul 2020 08:35:37 -0000

Hi Brian,


I'd like to suggest to merge the two patches into one.  Also, check your
log message of patch 2.  It looks like there's an empty line missing in
line 2.


Thanks,
Corinna

On Jul  9 19:15, Brian Inglis wrote:
> ---
>  faq/faq.html | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/faq/faq.html b/faq/faq.html
> index 846e087e..8659db5d 100644
> --- a/faq/faq.html
> +++ b/faq/faq.html
> @@ -57,10 +57,12 @@ freedoms, so it is free software.
>  <tr class="question"><td align="left" valign="top"><a name="faq.what.version"></a><p><b>1.5.</b></p></td>
>      <td align="left" valign="top"><p>What version of Cygwin <span class="emphasis"><em>is</em></span> this, anyway?</p></td></tr>
>  <tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top">
> -    <p>As the Cygwin DLL takes the place of a Unix kernel,
> -	to find the version of the Cygwin DLL installed,
> -	you can use any of the Unix compatible commands:
> +    <p>To find the version of the Cygwin DLL installed,
> +	you can use:
>  	<code class="command"><strong>uname&nbsp;-a</strong></code>;
> +        as you would for a Unix kernel.
> +        As the Cygwin DLL takes the place of a Unix kernel,
> +	you can also use any of the Unix compatible commands:
>  	<code class="command"><strong>uname&nbsp;-srvm</strong></code>;
>  	<code class="command"><strong>head&nbsp;/proc/version</strong></code>;
>  	or the Cygwin command:
> @@ -72,17 +74,18 @@ freedoms, so it is free software.
>      <p>If you are looking for the version number for the whole Cygwin release,
>  	there is none.
>  	Each package in the Cygwin release has its own version, and the
> -	<code class="package">cygwin</code> package containing the Cygwin DLL and
> -	Cygwin system specific utilities is just another (but very important!) package.
> +	<code class="package">cygwin</code> package containing the Cygwin DLL
> +	and Cygwin system specific utilities is just another (but very
> +	important!) package.
>  	The packages in Cygwin are continually improving, thanks to
>  	the efforts of net volunteers who maintain the Cygwin binary ports.
>  	Each package has its own version numbers and its own release process.
>  </p><p>So, how do you get the most up-to-date version of Cygwin?  Easy.  Just
>  download the Cygwin Setup program by following the instructions
>  <a class="ulink" href="https://cygwin.com/install.html" target="_top">here</a>.
> -The setup program will handle the task of updating the packages on your system
> -to the latest version. For more information about using Cygwin's
> -<code class="filename">setup.exe</code>, see 
> +The Setup program will handle the task of updating the packages on your system
> +to the latest version. For more information about using Cygwin's Setup program,
> +see 
>  <a class="ulink" href="https://cygwin.com/cygwin-ug-net/setup-net.html" target="_top">Setting Up Cygwin</a>
>  in the Cygwin User's Guide. 
>  </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.what.who"></a><p><b>1.6.</b></p></td><td align="left" valign="top"><p>Who's behind the project?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p><span class="bold"><strong>(Please note that if you have cygwin-specific
> @@ -706,7 +709,8 @@ user with <code class="literal">cygrunsrv -u</code> (see
>  information).
>  </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.using.path"></a><p><b>4.5.</b></p></td><td align="left" valign="top"><p>How should I set my PATH?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>This is done for you in the file /etc/profile, which is sourced by bash
>  when you start it from the Desktop or Start Menu shortcut, created by
> -<code class="literal">setup.exe</code>.  The line is
> +the Cygwin Setup program.
> +The line is
>  </p><pre class="screen">
>  	PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
>  </pre><p>Effectively, this <span class="bold"><strong>prepends</strong></span> /usr/local/bin and /usr/bin to your
> @@ -903,8 +907,7 @@ services like sshd) beforehand.</p><p>The only DLL that is sanctioned by the Cyg
>  you get by running <a class="ulink" href="https://cygwin.com/install.html" target="_top">setup-x86.exe or setup-x86_64.exe</a>,
>  installed in a directory controlled by this program.  If you have other
>  versions on your system and desire help from the cygwin project, you should
> -delete or rename all DLLs that are not installed by
> -<code class="filename">setup.exe</code>.
> +delete or rename all DLLs that are not installed by the Cygwin Setup program.
>  </p><p>If you're trying to find multiple versions of the DLL that are causing
>  this problem, reboot first, in case DLLs still loaded in memory are the
>  cause.  Then use the Windows System find utility to search your whole
> -- 
> 2.27.0

-- 
Corinna Vinschen
Cygwin Maintainer
