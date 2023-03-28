Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id B70ED3858D39
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:35:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B70ED3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2V8T-1qRy482owh-013tkM; Tue, 28 Mar 2023 12:35:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 00DFFA80BFF; Tue, 28 Mar 2023 12:35:02 +0200 (CEST)
Date: Tue, 28 Mar 2023 12:35:02 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jon TURNEY <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/3] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jon TURNEY <jon.turney@dronecode.org.uk>, cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:HoBafcCOjxQndBAoYZLeiW3422O12ctjE9yynhiRKDDtYXZ51GW
 pOfWv2DA4qsyWr4M9OrpLyZExQxZcImjxiNsV2bKDF2T8NNJ71oJhsxYg0hDZ/jux3Aw3Ky
 FaNbY/tro9iQESktbandts9/xO8LQjl0j/RjYK9iE8buS/0U9A9iJNGF8AK1CySlZ1lwpAn
 A4MULYUky0f63NOKnifSg==
UI-OutboundReport: notjunk:1;M01:P0:8Rs9/d7whwQ=;q3t2r/bTxKheKNarKinsAfKAGWp
 50jRV5xTnOvJKiQx6op0oWMkY6ZhHU/yKyjS3IhBlXJra/62wHc73dRRX2v22r/CIISup3wqw
 0a3JjxjsQTAJUY3/XXX9z0fnee+eafY0ED0CtZVbEScc1O1bNo4V3qL0a0HNs20vMLYXoFyVO
 bHkMEusNVRbBVCK0unfCSjNPyO2tjRUd+yhKN46uz0SlE0FTmnjNaRpdXHIjCLya+tGwA80CM
 xjA0lhPkD4Jyu9LOu97l1HpF59Yxf6pm41SVD1yEJqz72OB9jskWMysO4/sve4hAVp/qZxkU7
 nQz26AnuHqwBOPaUUt+2Zi4hDIqqYSBmzV4LqTHPJ/b3hLgeaPC8fmR8x3nTR/KG0Ot7nZZF3
 tl9kc2IVRPLTeZi+wBvsAXIiiWaRWAdwn2GdTM+f6fCmZd+pewQyewSo2oyjX6SQsf6lfQQzd
 XKrkQlXhFhNwle1X16hcpAfLF8mS0LF1RpQVcDz27UYQM0+WCAN66BTBftB/eMoAoG6eiPN19
 SBn9YXGK9j+ps7HV58dkbbExG1ZGrsEDj/cZl2TSABQ5rK2VlAMFb5BSY0nCb3decAzVT46Rx
 zTdVBAK1Vyb6YMQUy19mCmoA4DeEAHJQSNwzDvpkCeVsJ1uYdsVzWptMK+isvBzHYKYeP4SrP
 yQJLT5NhxO9N9/kdrTqXNHUANxJ0TZcUmRwSkaVoiA==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Apart from the doc change, the patch is ok now.

On Mar 28 10:17, Johannes Schindelin wrote:
> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index c6871ecf05..1678ff6575 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -1203,6 +1203,17 @@ schemata are the following:
>  	      See <xref linkend="ntsec-mapping-nsswitch-desc"></xref>
>  	      for a more detailed description.</listitem>
>    </varlistentry>
> +  <varlistentry>
> +    <term><literal>env</literal></term>
> +    <listitem>Derives the home directory of the current user from the
> +	      environment variable <literal>HOME</literal> (falling back to
> +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
> +	      <literal>USERPROFILE</literal>, in that order).  This is faster
> +	      than the <term><literal>windows</literal></term> schema at the
> +	      expense of determining only the current user's home directory
> +	      correctly.  This schema is skipped for any other account.
> +	      </listitem>
> +  </varlistentry>
>  </variablelist>

I'd rephrase that a bit here.  This is the description of the scheme
itself, so this should be something along the lines of "utilizes the
current environment ..." and "Right now only valid for db_home, see xref
linkend="ntsec-mapping-nsswitch-home"...

However, there's something strange going on, see below.

>  <para>
> @@ -1335,6 +1346,17 @@ of each schema when used with <literal>db_home:</literal>
>  	      See <xref linkend="ntsec-mapping-nsswitch-desc"></xref>
>  	      for a detailed description.</listitem>
>    </varlistentry>
> +  <varlistentry>
> +    <term><literal>env</literal></term>
> +    <listitem>Derives the home directory of the current user from the
> +	      environment variable <literal>HOME</literal> (falling back to
> +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
> +	      <literal>USERPROFILE</literal>, in that order).  This is faster
> +	      than the <term><literal>windows</literal></term> schema at the
> +	      expense of determining only the current user's home directory
> +	      correctly.  This schema is skipped for any other account.
> +	      </listitem>
> +  </varlistentry>
>    <varlistentry>
>      <term><literal>@ad_attribute</literal></term>
>      <listitem>AD only: The user's home directory is set to the path given

There's something wrong here. Building the docs, I get these new error
messages:

  docbook2texi://sect4[@id='ntsec-mapping-nsswitch-passwd']/variablelist[1]/varlistentry[5]/listitem/term: element not matched by any template
  docbook2texi://sect4[@id='ntsec-mapping-nsswitch-home']/variablelist/varlistentry[5]/listitem/term: element not matched by any template
  Element term in namespace '' encountered in listitem, but no template matches.
  Element term in namespace '' encountered in listitem, but no template matches.
  Element term in namespace '' encountered in listitem, but no template matches.
  Element term in namespace '' encountered in listitem, but no template matches.
  No template matches term in listitem.
  No template matches term in listitem.

It looks like this has something to do with the <term> expression?

Jon, do you have an idea?


Corinna
