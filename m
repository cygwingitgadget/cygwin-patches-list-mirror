Return-Path: <cygwin-patches-return-4831-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10940 invoked by alias); 8 Jun 2004 10:01:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10921 invoked from network); 8 Jun 2004 10:01:16 -0000
Date: Tue, 08 Jun 2004 10:01:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: make IPC_INFO visible to ipc system utilities only
Message-ID: <20040608100117.GA17957@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40C5871E.9010801@msgid.corpit.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C5871E.9010801@msgid.corpit.ru>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q2/txt/msg00183.txt.bz2

On Jun  8 13:30, Egor Duda wrote:
> Hi!
> 
> Currently IPC_INFO is defined whenever we include sys/sem.h, but struct
> seminfo, which is returned by semctl(IPC_INFO) is defined only for
> _KERNEL applications. This inconsistency breaks, for instance,
> libmudflap builds. I believe there's no point to have IPC_INFO in
> non-_KERNEL application

  as long as we can't get semctl(IPC_INFO) results right anyway.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  What is the author trying to tell me here?!?

Corinna

> Patch attached.
> 
> egor
> 

> 2004-Jun-08  Egor Duda <deo@corpit.ru>
> 
> 	* include/cygwin/ipc.h: Make IPC_INFO visible only for ipc system
> 	utilities, to make it consistent with declaration of struct seminfo.
> 

> Index: include/cygwin/ipc.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/ipc.h,v
> retrieving revision 1.6
> diff -u -p -2 -r1.6 ipc.h
> --- include/cygwin/ipc.h	3 Jun 2004 19:51:10 -0000	1.6
> +++ include/cygwin/ipc.h	8 Jun 2004 07:27:29 -0000
> @@ -49,5 +49,8 @@ struct ipc_perm
>  #define IPC_SET  0x1001		/* Set options. */
>  #define IPC_STAT 0x1002		/* Get options. */
> +
> +#ifdef _KERNEL
>  #define IPC_INFO 0x1003		/* For ipcs(8). */
> +#define
>  
>  #ifdef _KERNEL
> 


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
