Return-Path: <cygwin-patches-return-4649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30528 invoked by alias); 3 Apr 2004 12:50:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30509 invoked from network); 3 Apr 2004 12:50:03 -0000
Message-ID: <01C4198A.F026EA80.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: Support for SNDCTL_DSP_CHANNELS ioctl
Date: Sat, 03 Apr 2004 12:50:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: VrIZp6ZlgebBf2bF4W+htZF8crROvTmNRc+zeEAjSE7E-+NqaxHCUk
X-SW-Source: 2004-q2/txt/msg00001.txt.bz2

Hello,

This patch is based on the old version of the dsp device and should therefore
not go into the repository as submitted. It is a good idea to support this IOCTL
also. I will supply a version based on the current code in CVS.
I will also add SNDCTL_DSP_GETCAPS.

Gerd

On Wednesday, March 31, 2004 12:29 PM, Corinna Vinschen [SMTP:vinschen@redhat.com] wrote:
> Gerd, can you please review this patch and give your yay or nay?
> 
> Fabrizio, thanks for the patch but did you have a look onto
> http://cygwin.com/contrib.html ?
> 
> The ChangeLog formatting is wrong and usually you need have to send
> a copyright assignment form to Red Hat.  In this case it's actually
> a fairly small patch which can be treated as "insignificant".
> 
> Corinna
> 
> On Mar 31 11:39, fabrizio.ge@tiscali.it wrote:
> > Hello.
> > 
> > This patch adds support for calling the SNDCTL_DSP_CHANNELS ioctl on /dev/dsp.
> > The changelog is
> > 
> > 2004-03-31 Fabrizio Gennari (fabrizio.ge@tiscali.it)
> > - fhandler_dsp.cc(fhandler_dev_dsp::ioctl): add support for SNDCTL_DSP_CHANNELS
> > ioctl
> > 
> > It is almost a copy-and-paste from SNDCTL_DSP_STEREO
> > 
> > Bye
> > Fabrizio
> > 
> > __________________________________________________________________
> > ADSL Senza Canone 640Kbps:
> > attivala entro il 31 marzo e avrai GRATIS il costo di adesione,
> > quello di attivazione e il modem per tutto il 2004.
> > E per i primi 3 mesi navighi a 1,5 euro l'ora! Affrettati!
> > http://point.tiscali.it/adsl/prodotti/senzacanone/
> > 
> > 
> > 
> 
> > --- fhandler_dsp_old.cc	2003-11-26 03:15:07.001000000 +0100
> > +++ fhandler_dsp.cc	2004-03-12 10:11:50.830185600 +0100
> > @@ -591,6 +591,24 @@
> >        }
> >        break;
> >  
> > +      CASE (SNDCTL_DSP_CHANNELS)
> > +      {
> > +	int nChannels = *intptr;
> > +
> > +	s_audio->close ();
> > +	if (s_audio->open (audiofreq_, audiobits_, nChannels) == true)
> > +	  {
> > +	    audiochannels_ = nChannels;
> > +	    return 0;
> > +	  }
> > +	else
> > +	  {
> > +	    s_audio->open (audiofreq_, audiobits_, audiochannels_);
> > +	    return -1;
> > +	  }
> > +      }
> > +      break;
> > +
> >        CASE (SNDCTL_DSP_GETOSPACE)
> >        {
> >  	audio_buf_info *p = (audio_buf_info *) ptr;
> 
> 
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Developer                                mailto:cygwin@cygwin.com
> Red Hat, Inc.
