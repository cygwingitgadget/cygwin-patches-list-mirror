Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	by sourceware.org (Postfix) with ESMTPS id 356823858D1E
	for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023 16:06:50 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MfI21-1qCTDf3QYF-00gnGG for <cygwin-patches@cygwin.com>; Mon, 13 Mar 2023
 17:06:48 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 1608FA80C87; Mon, 13 Mar 2023 17:06:48 +0100 (CET)
Date: Mon, 13 Mar 2023 17:06:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: doc: Update postinstall/preremove scripts
Message-ID: <ZA9KGLJj1jHCoI0t@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230308141719.7361-1-jon.turney@dronecode.org.uk>
 <ZA7tWpqAmlcKg+v7@calimero.vinschen.de>
 <0cef86b3-ea03-a627-2847-2130a93872b3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cef86b3-ea03-a627-2847-2130a93872b3@dronecode.org.uk>
X-Provags-ID: V03:K1:8PwNPgA/Xv76jRe2ZezUEY1PMaVIMxjk/gSOm7ZUUKrpFVqE9d/
 /3EXEe10KAiIJxaJDrg/5pa7EehEtP8PFXQ3CJIpGpiE2C/9VgNVDHYWQXMPxFQfJhO5xZo
 L3Z1ZFCFo678PS3hp7m3IKcOyaQWqyEV5j2rhapBBjRCLMhUkUXtb2Bq3tSRyv5vbzJDBbS
 DvgTnA7x9kMDuERT1B8ug==
UI-OutboundReport: notjunk:1;M01:P0:kQHUiuH7qt8=;03mieSeTBMrx4v34o1i+Xmssd1a
 8cigopjfbVIt5d+HqopfECKS9yMdlp1pe7tPrhIwyvb4g8X0iii636EjXHBulcwudlZ8llVsD
 tCfGexGqtzVpKJLEUWtyNIEwrXpuytECIzbXbCAVnj8tWvtxHYxrij+lFm2Vz8F1XTNmHBFct
 5YsuoJXgR8DN5/bCSMS2ij0yzH4hjx8Z2uUmyhX2kE+o7+RLj/hzhwHTiPEFSw9ZtSLQ/9TaV
 3zlzsnJLlVN/QOHoK4RuiMjqEB/KLxDdNFyODEt9NQ1MU9qoXc/B5rlBPAUmYv3cmHlWUaBXN
 Flm62+bDdFVK+fRZJyG9mQfsF16lNuKeEoSRx7WQtgKWkJyDZ0P/HhBDIwcTW3mBmC/5iE2vL
 5TD8n7D6geZ7843abQKkncQ/ad9xZCF7f/TzRUvFcMkdaTwd+NkExYmhLtxUJjpTMCzppRNTy
 w0oE317XroEtEVdEOtQzRapi/3lYoPN+qHKQlziJNXaLbroULu/FYHr+WzcysACKo6uU3lCEQ
 WnttX7TFeFHFUsX96aVLeb7D02qJa+oAzWgP6FNEnOZchrAGdq1HmZzHWy1CoILauuGaWXTtG
 lR7qVRsmnh7W7drHXvn7C/oI9vf3zfaLuDbY3SWTv0X1hY86pQ4DQn2JGGw3Mkl++2UXLUhtF
 UJyiu9PgrgBcEEBObCMVIH6LYr3FCH5Mi/Y5PZy77A==
X-Spam-Status: No, score=-103.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 13 14:18, Jon Turney wrote:
> On 13/03/2023 09:31, Corinna Vinschen wrote:
> > Hi Jon,
> > 
> > On Mar  8 14:17, Jon Turney wrote:
> > > Update postinstall/preremove scripts to use CYGWIN_START_MENU_SUFFIX and
> > > CYGWIN_SETUP_OPTIONS.
> > 
> > It would be great if you could explain your change in the commit
> > message...
> > 
> 
> Yeah, that's fair. How about:
> 
> "Since setup 2.925, it indicates to postinstall and preremove scripts the
> start menu suffix to use via the CYGWIN_START_MENU_SUFFIX env var.
> 
> It also indicates, via the CYGWIN_SETUP_OPTIONS env var, if the option to
> disable startmenu shortcut creation is supplied.
> 
> Update the Cygwin documentation postinstall and preremove scripts to take
> these env vars into consideration."

Sure, sounds good

> 
> > >   winsup/doc/etc.postinstall.cygwin-doc.sh | 19 +++++++++++++++----
> > >   winsup/doc/etc.preremove.cygwin-doc.sh   |  8 ++++++--
> > >   2 files changed, 21 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/winsup/doc/etc.postinstall.cygwin-doc.sh b/winsup/doc/etc.postinstall.cygwin-doc.sh
> > > index 97f88a16d..313c1d3ff 100755
> > > --- a/winsup/doc/etc.postinstall.cygwin-doc.sh
> > > +++ b/winsup/doc/etc.postinstall.cygwin-doc.sh
> > > @@ -36,9 +36,20 @@ do
> > >   	fi
> > >   done
> > > +# setup was run with options not to create startmenu items
> > > +case ${CYGWIN_SETUP_OPTIONS} in
> > > +  *no-startmenu*)
> > > +    exit 0
> > > +    ;;
> > > +esac
> > > +
> > >   # Cygwin Start Menu directory
> > > -case $(uname -s) in *-WOW*) wow64=" (32-bit)" ;; esac
> > > -smpc_dir="$($cygp $CYGWINFORALL -P -U --)/Cygwin${wow64}"
> > > +if [ ! -v CYGWIN_START_MENU_SUFFIX ]
> > 
> > Isn't -v a bash extension? Ideally the shebang should reflect that.
> > Otherwise, -z?
> 
> This is actually controlled by setup, which runs postinstall and preremove
> scripts with an .sh extension using bash.
> 
> But yeah, I'll change the shebang.

Great. Just push when you're ready.


Thanks,
Corinna
