Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 2EA083857012
 for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021 19:52:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2EA083857012
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCX1-1lHESh34hF-00V67E for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021
 20:52:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8FBFFA80D7C; Mon, 15 Mar 2021 20:52:33 +0100 (CET)
Date: Mon, 15 Mar 2021 20:52:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
Message-ID: <YE+7ATqy4vJdHAp7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:BAKjsu/Lecq7E6B+O0iT8yxHtCCB1L9YkD6ooD9FHrfhvHgvv3i
 4R3T2Rt1zCdnaeys0xUHiLGIM5+uzO5QHEARunQu53gqKG0Fibv/Wi1XJP4TienwvTAGW7i
 ApxGGi+O+DXWBEpL4yhCZ0PIHUdiarZvzpgv4LgXqTGtXITAq02CK/jt1uVCCn+sLaGTcN8
 RKEv+iX2/L0Wrd5wYdFeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZP/v2neG6fM=:mzSRMX83CvW0cHpinXsFcl
 z/gY6bZYTBLiS6WpUHAb0JAPSLwW8o74l2JuugnwGDok7DWlfmSICT2Wz7ALiilXNxp5bNAj4
 cUBBr2hcQ3cwaHtz79bm81rdHN4bp+ivIB+RYZ20C7ZA4Y0NdPspXLcw2bbvX7GWd7NaKjGyS
 5mnziC0g3HxVxW13FA3VQjMgQqtBvSAHKg9LCEt5Fd5zqm+BYci2orN18PjZEToZ4nH2B/yiN
 cOxxKM4rz5wZScE5K0kKu90/reGhYDgYT9JEUea/3nhq3MN0vpgSduH7gaT/feAoMrF9vJxuo
 teN+uSMeHG36Pw6/5AaNjmtSAbReIZp68Qj0CpEMeNP3PHsHrXiIlD2qZmpshod5+yQ6BzirB
 xBpDrxuYyk8vaiZNDaKvpcdbO8f1IAHt9Di62ZcyP2eZnvkYYs1vr1qHHOOrqaAd4F7E/nzyv
 oMDdrBFLuQ==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 15 Mar 2021 19:52:38 -0000

Hi Johannes,

I'm not opposed to treat these applinks as symlinks.  I have a
suggestion and a style nit, though.

On Mar 12 16:11, Johannes Schindelin via Cygwin-patches wrote:
> When the Windows Store version of Python is installed, so-called "app
> execution aliases" are put into the `PATH`. These are reparse points
> under the hood, with an undocumented format.
> 
> We do know a bit about this format, though, as per the excellent analysis:
> https://www.tiraniddo.dev/2019/09/overview-of-windows-execution-aliases.html
> 
> 	The first 4 bytes is the reparse tag, in this case it's
> 	0x8000001B which is documented in the Windows SDK as
> 	IO_REPARSE_TAG_APPEXECLINK. Unfortunately there doesn't seem to
> 	be a corresponding structure, but with a bit of reverse
> 	engineering we can work out the format is as follows:
> 
> 	Version: <4 byte integer>
> 	Package ID: <NUL Terminated Unicode String>
> 	Entry Point: <NUL Terminated Unicode String>
> 	Executable: <NUL Terminated Unicode String>
> 	Application Type: <NUL Terminated Unicode String>

Given we know this layout, what about introducing a matching struct,
like I did for REPARSE_LX_SYMLINK_BUFFER, for instructional purposes?

I. e.

typedef struct _REPARSE_APPEXECLINK_BUFFER
{
  DWORD ReparseTag;
  WORD  ReparseDataLength;
  WORD  Reserved;
  struct {
    DWORD Version;       /* Take member name with a grain of salt. */
    WCHAR Strings[1];	 /* Four serialized, NUL-terminated WCHAR strings:
			    - Package ID
			    - Entry Point
			    - Executable Path
			    - Application Type
			    We're only interested in the Executable Path */
  } AppExecLinkReparseBuffer;
} REPARSE_APPEXECLINK_BUFFER,*PREPARSE_APPEXECLINK_BUFFER;


> +  else if (!remote && rp->ReparseTag == IO_REPARSE_TAG_APPEXECLINK)
> +    {
> +      /* App execution aliases are commonly used by Windows Store apps. */
> +      WCHAR *buf = (WCHAR *)(rp->GenericReparseBuffer.DataBuffer + 4);

Analogue:

     PREPARSE_APPEXECLINK_BUFFER rpl = (PREPARSE_APPEXECLINK_BUFFER) rp;
     WCHAR *buf = rpl->AppExecLinkReparseBuffer.Strings;

Maybe use 'str' or 'strp' here, instead of buf?

> +      for (int i = 0; i < 3 && size > 0; i++)
> +        {
> +	  n = wcsnlen (buf, size - 1);
> +	  if (i == 2 && n > 0 && n < size)
> +	    {
> +	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHAR));
                                                                  ^^^
                                                                  space


Thanks,
Corinna
