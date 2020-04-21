Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 28B64384B0C1
 for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020 09:12:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28B64384B0C1
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhWx1-1imnR82N9P-00ech4 for <cygwin-patches@cygwin.com>; Tue, 21 Apr 2020
 11:12:05 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DAE73A8270E; Tue, 21 Apr 2020 11:12:03 +0200 (CEST)
Date: Tue, 21 Apr 2020 11:12:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v2] Cygwin: accounts: Unify nsswitch.conf db_* defaults
Message-ID: <20200421091203.GA1654005@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200420192047.000069a0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420192047.000069a0@gmail.com>
X-Provags-ID: V03:K1:qKDd2h2kRp0E/CQofTlNmW2vhIUFMCsZNbEAefioKVkxRNubCs5
 BI05CYAivLwep2SmvsViMgNtvxl2cvyy4xGQd7OJ82ZQxFNu7s6ZycD8TDA/hY0R/5mKw3M
 lV6D6UMii5ruqgJFlmsTKXiVbTshq96A7K4pIbhnpSdWywP7yces4ENgj3ZBR/6YFYkpUE+
 JX6Hi1X1W9zUci9DyP9Mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZCtHoYg7cig=:yqB2cchGCNONT8T2uO6eqI
 ZVe29l9V7nszMkuilp0N1Jv/idCjYkbCcNjICQ80aqkgkS93pFlpO1jeoJx7NNNS9Yb5llrNj
 nDNSSAWqF8kROHW5sllLdC8tv9g7R5rCry3z3c+rdFznkaZXePpEWTsR5AjsSEiI1nWeH9CKB
 nEawRvivF1VZJyqccWpJRoHhkix2oQURI+F8IC5Ktga/htMvujz7lO6yPBgQmXwiaaOqF4msq
 RZF185dqPIXKS1c/bRdN/cREdEy2R6QDK7aW15UcMqOgLFoMlX72rkAZyR0TtmuTFC3ph/QSj
 A6/esIQ637ZJDtzXnqvHZlas2rW06QDEUmM6wCUDAhFeLtsVUrDPDdFFcysjRKFb8ZJzLjFSF
 IXu5lzL0ba5jEUKSH/NlP5PSZdlWofe1s2aBFCGrDtEANBy2lTUkeZ5l+GtN7KviPOlEkvVbO
 KkO0Zn4J86WwwsYUwCBrDecx9BBzPzDmX5ps++6e7JfEea2P9CiAhN4Fq9IFYAbpPQqSCH2WX
 cy3I+UuxE1fFM6+bOi4afpV5nCSU6l5lZV1kLDL4XJrl1GtbYpZNF0ezKwfveRHiIKpOr/Lo7
 KxMAdIB0CKngdUAyqM9XefzI3aQN8oevTSTz7PN1sVMOGHNQCn4LRMohODHTCfx8HuVlknU56
 ZmDJk0ouXbGo2SYPn1xy/KRa2SfNVuu83H83Wo4uhK2qnPI6jwIAFDraQfdrDA0yGH6yp3LYb
 Qaja6CI7IcXmuY1g1UYLs573fKPf7/v8HQwlnrlQQUmDbrjIdh2fyDcuQMS7pXJjD1nLqwp05
 sA1Uu/lWRpvv59gkY+gJVSNtZU3NryHNothSeaFN4fHlaf2aQzoX9187HHN7rqv8OSeisIp
X-Spam-Status: No, score=-106.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3, GOOD_FROM_CORINNA_CYGWIN,
 KAM_DMARC_STATUS, KAM_LIST3_1, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Apr 2020 09:12:09 -0000

Hi David,

source patch is ok, just the docs...

On Apr 20 19:20, David Macek via Cygwin-patches wrote:
> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> index 5287845686..032bebe4dc 100644
> --- a/winsup/doc/ntsec.xml
> +++ b/winsup/doc/ntsec.xml
> @@ -874,9 +874,6 @@ set up to all default values:
>    db_prefix:    auto
>    db_separator: + -->
>    db_enum:  cache builtin
> -  db_home:  /home/%U
> -  db_shell: /bin/bash
> -  db_gecos: &lt;empty&gt;
>  </screen>

I'm not exactly happy with removing these lines.  While your patch is
*technically* correct in terms of schemata, these *are* the default
values.  The target audience are users.  A simple overview like the
above is helpful to just look up the defaults, while the technical
description below is for the more in-depth view.

So from my POV this hunk should be remove from your patch.

>  <sect4 id="ntsec-mapping-nsswitch-syntax"><title id="ntsec-mapping-nsswitch-syntax.title">The <filename>/etc/nsswitch.conf</filename> syntax</title>
> @@ -1508,15 +1505,8 @@ of each schema when used with <literal>db_home:</literal>
>  
>  <para>
>  As has been briefly mentioned before, the default setting for
> -<literal>db_home:</literal> is
> -</para>
> -
> -<screen>
> -  db_home: /home/%U
> -</screen>
> -
> -<para>
> -So by default, Cygwin just sets the home dir to
> +<literal>db_home:</literal> defines no schemata, which means only the fallback
> +option is used, so by default, Cygwin just sets the home dir to

Just adding text on top and trying to keep the former wording intact
doesn't do justice to the actual change here.  I'd like to suggest a
stronger rephrasing, along the lines of

  <literal>db_home:</literal> defines no default schemata.  If this
  setting is not present in <filename>/etc/nsswitch.conf</filename>,
  the fallback is to set the home directory to 
  <filename>/home/$USERNAME</filename>.  This is equivalent to
  a <filename>/etc/nsswitch.conf</filename> settting of

  <screen>
    db_home: /home/%U
  </screen>

Same or similar in the db_shell case.  db_gecos is fine as is.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
