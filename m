Return-Path: <cygwin-patches-return-3136-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15725 invoked by alias); 7 Nov 2002 02:55:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15705 invoked from network); 7 Nov 2002 02:55:11 -0000
Message-ID: <00ca01c28608$beb21f40$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <00ba01c285e4$620b2350$0201a8c0@sos> <20021107022144.GB6144@redhat.com> <00c501c28606$05629df0$0201a8c0@sos>
Subject: Re: utmp database manipulations patch
Date: Wed, 06 Nov 2002 18:55:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00087.txt.bz2

Looks like it's better to define UT_IDLEN as 4 to be compatible with linux
and solaris...

Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, November 06, 2002 9:33 PM
Subject: Re: utmp database manipulations patch


> Here are my proposed changes I'd like to include into utmp.h too. With
these
> changes getutid() in syscalls.cc should be modified to use UT_IDLEN as 3rd
> parameter of strncmp().
>
> Index: utmp.h
> ===================================================================
> RCS file: /cvs/src/src/newlib/libc/sys/cygwin/sys/utmp.h,v
> retrieving revision 1.5
> diff -u -p -r1.5 utmp.h
> --- utmp.h      2 May 2002 00:59:39 -0000       1.5
> +++ utmp.h      7 Nov 2002 02:26:22 -0000
> @@ -14,6 +14,7 @@
>  #include <paths.h>
>
>  #define UTMP_FILE _PATH_UTMP
> +#define WTMP_FILE _PATH_WTMP
>
>  #ifdef __cplusplus
>  extern "C" {
> @@ -22,6 +23,7 @@ extern "C" {
>  #define UT_LINESIZE    16
>  #define UT_NAMESIZE    16
>  #define UT_HOSTSIZE    256
> +#define UT_IDLEN       2
>  #define ut_name ut_user
>
>  struct utmp
> @@ -29,7 +31,7 @@ struct utmp
>   short ut_type;
>   pid_t ut_pid;
>   char  ut_line[UT_LINESIZE];
> - char  ut_id[2];
> + char  ut_id[UT_IDLEN];
>   time_t ut_time;
>   char  ut_user[UT_NAMESIZE];
>   char  ut_host[UT_HOSTSIZE];
>
> Sergey Okhapkin
> Somerset, NJ
> ----- Original Message -----
> From: "Christopher Faylor" <cgf@redhat.com>
> To: <cygwin-patches@cygwin.com>
> Sent: Wednesday, November 06, 2002 9:21 PM
> Subject: Re: utmp database manipulations patch
>
>
> > On Wed, Nov 06, 2002 at 05:32:23PM -0500, Sergey Okhapkin wrote:
> > >The patch fixes some bugs in utmp database support and provides a new
> > >pututline() call.
> > >
> > >2002-11-06  Sergey Okhapkin  <sos@prospect.com.ru>
> > >
> > >        * cygwin.din (pututline): new exported function.
> > >        * syscalls.cc (login): Use pututiline().
> > >          (setutent): Open utmp as read/write.
> > >          (endutent): Check if utmp file is open.
> > >          (utmpname): call endutent() to close current utmp file.
> > >          (getutid): Enable all cases, use strncmp() to compare ut_id
> fields.
> > >          (pututline): New.
> > >        * tty.cc (create_tty_master): Set ut_pid to current pid.
> >
> > Looks good to me.
> >
> > I've checked this in, along with reformatting the ChangeLog and bumping
> > the API minor version number.
> >
> > cgf
>
>

