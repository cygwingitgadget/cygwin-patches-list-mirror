Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 49B02385783A
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 19:15:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 49B02385783A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MZCKd-1k2CYG3T4T-00V6St for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 21:15:41 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 41A0BA83A8D; Tue,  8 Sep 2020 21:15:41 +0200 (CEST)
Date: Tue, 8 Sep 2020 21:15:41 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/3] Cygwin: path_conv::check: handle error from
 fhandler_process::exists
Message-ID: <20200908191541.GS4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200908190246.48533-1-kbrown@cornell.edu>
 <f73dd163-6875-5f66-4b0c-4196f245bed3@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f73dd163-6875-5f66-4b0c-4196f245bed3@cornell.edu>
X-Provags-ID: V03:K1:KtjQfIQnxp2A+cYq3yB8IjerFTQ4+3pfMY8XqgoAdeNip0ecbnd
 LlT4QHo+2+f9GGkhm5bOFrQlE+O0S18ZX7gRqgHgWrM+7wgjx9F2GtEwpQ+c4JZcI/a+Kcd
 VPbEISgINytn+QAuF/u4ZPjUn3kEnjL8v994acIERQEMwSjs80FDtuWLFt6C9sGtUhkukT1
 fvdNB3b5FAYEzq6ph21Vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2vkpF/Po470=:4nIxPBz62si+tZZpzw6ut5
 SvG2ddniZkC/ybycy8Vvy3rX/JdElwf4E505zU5Q75a8jFg/cJQ78gIlhcINBXQz4I0lFluz3
 XFe0BlWVhbABhCRIIo+rvN/kwwLxzrpZKAX9jHQwEyVrliWtRREKoBOZ1NzItprttBawJy9/M
 SQWruOSKruZoG16scE/rqjZiTMfIuJB/9UHu8a+wlMezp+wIcFLuI6MPMhPqWDdD8rLnv5fP2
 XwS14KXKZca3MymXaJ3KlD5fM7uwSRD/IjhkaJTZG7YcEiVAY5mXLPh+bKYIVCG/Xp1eANiPW
 G/k1QbMRujp/ph1Uy7ikxH/xElrLBldnNlY1u3iZ4l53m+8mOiS8UjCEQv1VEgsUC9ZG/KYXu
 zFLF5U950oYEnuiwWfhEkE+70vTeiIniY/5LQd/jCGHyez3rta+FSR9CbbRRQc8sqJwRBV6+k
 Ohed0W1rP+fFgNS6o673Yq0jxN7TciEnx8pWFPvqs5yBb92rsyoBOq8kcJd2Kd9QgtAy2Upwq
 mB4l3acBOkCfQq8LEdN42ZTqJKoOJxeSxSgP781LYhEi7KvAjf9QvYXUA1MuBicD1M4wVgetE
 7FoIVY+pEKGz5GrnBNM8l3Ouv/XJe0jrX/jOA16a30NOtu8+IsCDp0cNC1UUhdXEtzgKN3PYo
 ViNwusus4NYjTwC9aQj2+cS5vhbmEle761Suntg3EllCPx3jQSDyQFV/3l3iYv+gQgxrMgIyk
 3L2S84CnLyR4DeGf6SfOOp5aLoC1Cx+ICnul6BcUaX+KAJvml2lF3jQNnBPXfa1tYmRdzdnKN
 DP2l68Iq6MF6u4PGaoHKNoIYL2xCmkiXtJZ5IwJrpcImiCsnk0uYwhbR8OQFihxIfaQLgYach
 pb9ENQi+4bfS4BzbEiHw==
X-Spam-Status: No, score=-105.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 08 Sep 2020 19:15:44 -0000

On Sep  8 15:05, Ken Brown via Cygwin-patches wrote:
> On 9/8/2020 3:02 PM, Ken Brown via Cygwin-patches wrote:
> > fhandler_process::exists is called when we are checking a path
> > starting with "/proc/<pid>/fd".  If it returns virt_none and sets an
> > errno, there is no need for further checking.  Just set 'error' and
> > return.
> > ---
> >   winsup/cygwin/path.cc | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > index 95faf8ca7..1d0c38a20 100644
> > --- a/winsup/cygwin/path.cc
> > +++ b/winsup/cygwin/path.cc
> > @@ -809,6 +809,15 @@ path_conv::check (const char *src, unsigned opt,
> >   			  delete fh;
> >   			  goto retry_fs_via_processfd;
> >   			}
> > +		      else if (file_type == virt_none && dev == FH_PROCESSFD)
> > +			{
> > +			  error = get_errno ();
> > +			  if (error)
> > +			    {
> > +			      delete fh;
> > +			      return;
> > +			    }
> > +			}
> >   		      delete fh;
> >   		    }
> >   		  switch (file_type)
> > 
> 
> The subject should say "2/2", not "2/3".  I have a local third patch
> documenting the bug fix, which I didn't bother to send.

ACk to both patches, 2 and 3 ;)


Corinna
