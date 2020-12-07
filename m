Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id C0D4C3894C35
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 15:35:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C0D4C3894C35
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MspyA-1jtMTZ2KV6-00tGLf for <cygwin-patches@cygwin.com>; Mon, 07 Dec 2020
 16:35:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 34220A80706; Mon,  7 Dec 2020 16:35:13 +0100 (CET)
Date: Mon, 7 Dec 2020 16:35:13 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Allow to set SO_PEERCRED zero (v2)
Message-ID: <20201207153513.GK5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207102936.1527-1-mark@maxrnd.com>
 <20201207153025.GJ5295@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207153025.GJ5295@calimero.vinschen.de>
X-Provags-ID: V03:K1:Uv/MvGGOHk51/QELxwXZZVMfMlxSjtQpebYQdzrW8FzlbtMBxsO
 aM1cIij+sGqKR80v85g1GHuGWHSXNLA8wwl5twsrnh3PMpbP684KWSIDHtQct73gVp3++tF
 27YvbJz4fADmblBx9nVs58ZbnfXJBULiwWGTlOMGUNmR9dI1oRpomSBvkfys3MEtEyFqYLk
 zyFyTNPBaS8Z4/yuilg3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LPc5NBQ79dw=:AjU5gAjHnXF8QSNOKYm5di
 kH4OcCl3KK8foHkHRvzdjkBctVexFtidMXk0LXhJ5dxXUI9DX4eHgMa99+xbU+DOzXdKM4vTY
 bFw3LgZWzQYUEKKE+NaW8QeBFTS7X+tohOtqJnDWQ1n3NNeLm0gsnlfTL5N62GDbohvY57TEJ
 3fUMA9HUG9lC9mf7Qa8CwriT6xfOPlexCVYlXWhsUA4xiDVVnizySCJ80RQ/HAYJEhwIQKKdf
 zqjbh4jSMGk7+N1HzGvRxxO2SSQU7+JPcW3zkNtFfnc/U579HsHcl5KUA60Fm0SCtIKNHeUqe
 gyfC+qtMTV5ctHospAj5IAdJLFTGfzQEhlHpeJlbCfIsIbTrPS7jsiGcsCN6ji8JO47dxHfNy
 yszmDzO562NgFiGPpjthRDdmyx6ZxVYU0Okyvc+ZC24HoB3lNRBPVF8PLgN1ngYpSGrn/eglR
 AFQWG0uweQ==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 07 Dec 2020 15:35:16 -0000

On Dec  7 16:30, Corinna Vinschen via Cygwin-patches wrote:
> On Dec  7 02:29, Mark Geisert wrote:
> > The existing code errors as EINVAL any attempt to set a value for
> > SO_PEERCRED via setsockopt() on an AF_UNIX/AF_LOCAL socket.  But to
> > enable the workaround set_no_getpeereid behavior for Python one has
> > to be able to set SO_PEERCRED to zero.  Ergo, this patch.  Python has
> > no way to specify a NULL pointer for 'optval'.
> > 
> > This v2 of patch allows the original working (i.e., allow NULL,0 for
> > optval,optlen to mean turn off SO_PEERCRED) in addition to the new
> > working described above.  The sense of the 'if' stmt is reversed for
> > readability.
> > 
> > ---
> >  winsup/cygwin/fhandler_socket_local.cc | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_socket_local.cc b/winsup/cygwin/fhandler_socket_local.cc
> > index c94bf828f..964f3e819 100644
> > --- a/winsup/cygwin/fhandler_socket_local.cc
> > +++ b/winsup/cygwin/fhandler_socket_local.cc
> > @@ -1430,10 +1430,14 @@ fhandler_socket_local::setsockopt (int level, int optname, const void *optval,
> >  	     FIXME: In the long run we should find a more generic solution
> >  	     which doesn't require a blocking handshake in accept/connect
> >  	     to exchange SO_PEERCRED credentials. */
> > -	  if (optval || optlen)
> > -	    set_errno (EINVAL);
> > -	  else
> > +	  /* Temporary: Allow SO_PEERCRED to only be zeroed. Two ways to
> > +	     accomplish this: pass NULL,0 for optval,optlen; or pass the
> > +	     address,length of an '(int) 0' set up by the caller. */
> > +	  if ((!optval && !optlen) ||
> > +		(optlen == (socklen_t) sizeof (int) && !*(int *) optval))
> >  	    ret = af_local_set_no_getpeereid ();
> > +	  else
> > +	    set_errno (EINVAL);
> >  	  return ret;
> >  
> >  	case SO_REUSEADDR:
> > -- 
> > 2.29.2
> 
> Pushed

I created new developer snapshots for testing.


Corinna
