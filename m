Return-Path: <cygwin-patches-return-3112-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31228 invoked by alias); 4 Nov 2002 04:26:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31174 invoked from network); 4 Nov 2002 04:26:42 -0000
Date: Sun, 03 Nov 2002 20:26:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Modified pthread types
Message-ID: <20021104042834.GA17407@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0207051023340.304-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0207051023340.304-200000@algeria.intern.net>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00063.txt.bz2

I'm going through my mailbox cleaning up old patches.

AFAICT, this patch wasn't applied.  Was there a reason for that?

cgf

On Fri, Jul 05, 2002 at 10:38:33AM +0200, Thomas Pfaff wrote:
>I have attached a patch with modified (dummy) pthread typedefs.
>
>This should give the compiler a chance to do some type validations,
>for example:
>
>pthread_t t;
>pthread_create(t,...) //wrong
>pthread_create(&t,...) // right
>
>pthread_cancel(t) //right
>pthread_cancel(&t)//wrong
>
>With the actual typedefs as void * the compiler will treat all versions
>valid.
>
>Thomas
>
>Changelog
>
>2002-07-05  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* include/semaphore.h: Modified typedef for sem_t.
>	* include/cygwin/types.h: Modified typedefs for pthread_t,
>	pthread_mutex_t, pthread_key_t, pthread_attr_t,
>	pthread_mutexattr_t, pthread_condattr_t, pthread_cond_t,
>	pthread_rwlock_t and pthread_rwlockattr_t.
>
>

>diff -urp src.old/winsup/cygwin/include/cygwin/types.h src/winsup/cygwin/include/cygwin/types.h
>--- src.old/winsup/cygwin/include/cygwin/types.h	Tue Jun 11 04:52:18 2002
>+++ src/winsup/cygwin/include/cygwin/types.h	Fri Jul  5 10:02:31 2002
>@@ -61,14 +61,21 @@ typedef __gid16_t gid_t;
> 
> #if !defined(__INSIDE_CYGWIN__) || !defined(__cplusplus)
> 
>-typedef void *pthread_t;
>-typedef void *pthread_mutex_t;
>+typedef struct {char __dummy;} __pthread_t;
>+typedef __pthread_t *pthread_t;
>+typedef struct {char __dummy;} __pthread_mutex_t;
>+typedef __pthread_mutex_t *pthread_mutex_t;
> 
>-typedef void *pthread_key_t;
>-typedef void *pthread_attr_t;
>-typedef void *pthread_mutexattr_t;
>-typedef void *pthread_condattr_t;
>-typedef void *pthread_cond_t;
>+typedef struct {char __dummy;} __pthread_key_t;
>+typedef __pthread_key_t *pthread_key_t;
>+typedef struct {char __dummy;} __pthread_attr_t;
>+typedef __pthread_attr_t *pthread_attr_t;
>+typedef struct {char __dummy;} __pthread_mutexattr_t;
>+typedef __pthread_mutexattr_t *pthread_mutexattr_t;
>+typedef struct {char __dummy;} __pthread_condattr_t;
>+typedef __pthread_condattr_t *pthread_condattr_t;
>+typedef struct {char __dummy;} __pthread_cond_t;
>+typedef __pthread_cond_t *pthread_cond_t;
> 
>   /* These variables are not user alterable. This means you!. */
> typedef struct
>@@ -77,8 +84,10 @@ typedef struct
>   int state;
> }
> pthread_once_t;
>-typedef void *pthread_rwlock_t;
>-typedef void *pthread_rwlockattr_t;
>+typedef struct {char __dummy;} __pthread_rwlock_t;
>+typedef __pthread_rwlock_t *pthread_rwlock_t;
>+typedef struct {char __dummy;} __pthread_rwlockattr_t;
>+typedef __pthread_rwlockattr_t *pthread_rwlockattr_t;
> 
> #else
> 
>diff -urp src.old/winsup/cygwin/include/semaphore.h src/winsup/cygwin/include/semaphore.h
>--- src.old/winsup/cygwin/include/semaphore.h	Wed Mar 21 16:06:22 2001
>+++ src/winsup/cygwin/include/semaphore.h	Fri Jul  5 10:02:32 2002
>@@ -21,7 +21,8 @@ extern "C"
> #endif
> 
> #ifndef __INSIDE_CYGWIN__
>-  typedef void *sem_t;
>+  typedef struct {char __dummy;} __sem_t;
>+  typedef __sem_t *sem_t;
> #endif
> 
> #define SEM_FAILED 0
