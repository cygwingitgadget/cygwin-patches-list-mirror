Return-Path: <cygwin-patches-return-1918-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 3407 invoked by alias); 27 Feb 2002 17:37:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1936 invoked from network); 27 Feb 2002 17:35:09 -0000
Message-ID: <BDF28C498CFED4119D720002B330B89301200A7A@xhole.bre.de.adp.com>
From: "Markus K. E. Kommant" <Markus.Kommant@de.adp.com>
To: cygwin-patches@cygwin.com
Subject: automatic TZ env-variable in localtime "problem" with W2000-germa
	n
Date: Wed, 27 Feb 2002 10:07:00 -0000
Importance: low
X-Priority: 5
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1BFB5.18148BB0"
X-SW-Source: 2002-q1/txt/msg00275.txt.bz2

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1BFB5.18148BB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-length: 2135

Hello,
I have the following problem, or misunderstandig(!) of TZ variable in
cygwin1.dll.

Problem (and my current solution)

When I do not set TZ to a valid value, all times will be showed as GMT (or
UTC) time.
The automatic generated TZ variable in localtime.cc will generate a name
from GetTimeZoneInformation.

When I test this algorithm in a program, the name will be invalid (longer
than 3 characters).

At the moment I have problems to rebuild the cygwin1.dll (make will make a
lot of things but I do find a simple make cygwin1.dll...)

Is it a good, bad, very bad idea to test the length of the name against 3 to
generate a TZ variable compatible with tzparse?


localtime.cc (not tested, because I was not able to build cygwin1.dll)

	    GetTimeZoneInformation(&tz);
(...)
	    for (src = tz.StandardName; *src; src++)
	      if (is_upper(*src)) *dst++ = *src;

	    /* not 3 characters for timezone _tzname[0] ? 
               happens for example in Win2000/NT german version
               a) tz.StandardName is a WideChar String
               b) is very long "Westeropaische Normalzeit"
               generate a TZ variable relative to GMT-x
               (if strlen of _tzname is not equal 3 , tzparse will 
                not accept the TZ variable!)
               mkt */
            if (strlen(cp) != 3)            /* mkt */
            {                               /* mkt */
               strcpy(cp, "GMT");           /* mkt */
               dst = cp + 3;                /* mkt */
            }                               /* mkt */

(...) same for the daylight saving time with DST.

When I call this function as a separate routine win32_tzset (roughly written
in win32_tzset.c for my VC program and Cygwin-GNU ports) the TZ variable
will be understood and the correct times will be chown.

pdksh port with a call to win32_tzset to set TZ automatically from Windows
Control Panel:
pdksh $ echo $TZ
GMT-1DST-2,M3.5.0/2,M10.5.0/3
pdksh $ date
Mon Feb 11 17:35:54  2002
(yes this the current time)

bash-2.05a$ date
Mon Feb 11 16:36:25  2002
(no, this the UTC time)


 <<win32_tzset.c>>  <<localtime.cc>> 


------_=_NextPart_000_01C1BFB5.18148BB0
Content-Type: application/octet-stream;
	name="win32_tzset.c"
Content-Disposition: attachment;
	filename="win32_tzset.c"
Content-length: 3621

#include <windows.h>
#include <winbase.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/timeb.h>

#ifdef __GNUC__
static long _dstbias=0;
#endif

void win32_tzset( void )
{
	tzset();

	if (((char*)getenv("TZ") == (char*)NULL) && (_timezone == 0))
	{
		TIME_ZONE_INFORMATION tzinfo;
		DWORD tzstate;
		int dstflag=0;
		static char TZ[40];
		char tmp_str[40];
		long i,j,g,k;
		
		/* printf("try to build up a TZ Variable from Windows Date Control Panel!\n"); */
		if ( (tzstate = GetTimeZoneInformation( &tzinfo )) != 0xFFFFFFFF )
		{
		/*
		* Must be very careful in determining whether or not DST is
		* really in effect.
			*/
			if ( (tzstate == TIME_ZONE_ID_DAYLIGHT) &&
				(tzinfo.DaylightDate.wMonth != 0) &&
				(tzinfo.DaylightBias != 0) )
				dstflag = 1;
			else
			/*
			* When in doubt, assume standard time
			*/
			dstflag = 0;
		}
		else
			dstflag = 0; /* When in doubt, assume standard time */
		
		_timezone = tzinfo.Bias * 60L;
		
		if ( tzinfo.StandardDate.wMonth != 0 )
			_timezone += (tzinfo.StandardBias * 60L);
		
		if ( (tzinfo.DaylightDate.wMonth != 0) &&
			(tzinfo.DaylightBias != 0) )
		{
			_daylight = 1;
			_dstbias = (tzinfo.DaylightBias - tzinfo.StandardBias) *
				60L;
		}
		else 
		{
			_daylight = 0;
			_dstbias = 0;
		}
		
		_tzname[0] = "GMT";
		_tzname[1] = "DST";
		
		/* BUILD UP TZ STRING */
		/* always relativ to GMT Time */
		
		strcpy(TZ,"TZ=GMT"); /* probably UTC for Universal StandardTime */
		
		if (_timezone > 0)
		{
			strcat(TZ,"+");
			i=_timezone;
		}
		else
		{
			strcat(TZ,"-");
			i=_timezone * -1;
		}
		j=i % 60L; /* Minutenausgleich */
		g=j % 60L; /* Sekundenausgleich */
		i=i / 3600L; 
		
		sprintf(tmp_str,"%ld", i);
		strcat(TZ,tmp_str);
		
		if (j | g)
		{
			sprintf(tmp_str,":%ld", j);
			strcat(TZ,tmp_str);
		}
		
		if (g)
		{
			sprintf(tmp_str,":%ld", g);
			strcat(TZ,tmp_str);
		}
		
		
		if (_daylight)
		{
			strcat(TZ,"DST"); /* DaylightSavingTime */
			
			k=_timezone + _dstbias; /* absolut differenz */
			
			if (k > 0)
			{
				strcat(TZ,"+");
				i=k;
			}
			else
			{	
				strcat(TZ,"-");
				i=k * -1;
			}
			j=i % 60L; /* Minutenausgleich */
			g=j % 60L; /* Sekundenausgleich */
			i=i / 3600L; 
			
			sprintf(tmp_str,"%ld", i);
			strcat(TZ,tmp_str);
			
			if (j | g)
			{
				sprintf(tmp_str,":%ld", j);
				strcat(TZ,tmp_str);
			}
			if (g)
			{
				sprintf(tmp_str,":%ld", g);
				strcat(TZ,tmp_str);
			}
			
			
			/* when to switch DST on ?*/
			sprintf(tmp_str,",M%d.%d.%d/%d",
				tzinfo.DaylightDate.wMonth,
				tzinfo.DaylightDate.wDay,
				tzinfo.DaylightDate.wDayOfWeek
				tzinfo.DaylightDate.wHour);
			strcat(TZ,tmp_str);

			if (tzinfo.DaylightDate.wMinute || tzinfo.DaylightDate.wSecond)
			{
				sprintf(tmp_str,",:%d", tzinfo.DaylightDate.wMinute);
				strcat(TZ,tmp_str);
			}
			if (tzinfo.DaylightDate.wSecond)
			{
				sprintf(tmp_str,",:%d", tzinfo.DaylightDate.wSecond);
				strcat(TZ,tmp_str);
			}
		    
			
			/* when to switch DST off, back to StandardDate ?*/
			sprintf(tmp_str,",M%d.%d.%d/%d",
				tzinfo.StandardDate.wMonth,
				tzinfo.StandardDate.wDay,
				tzinfo.StandardDate.wDayOfWeek,
				tzinfo.StandardDate.wHour);
			strcat(TZ,tmp_str);

			if (tzinfo.StandardDate.wMinute || tzinfo.StandardDate.wSecond)
			{
				sprintf(tmp_str,",:%d", tzinfo.StandardDate.wMinute);
				strcat(TZ,tmp_str);
			}
			if (tzinfo.StandardDate.wSecond)
			{
				sprintf(tmp_str,",:%d", tzinfo.StandardDate.wSecond);
				strcat(TZ,tmp_str);
			}
		}
		
		/* printf("\nbuild up TZ string: TZ=%s\n", TZ); */
		putenv(TZ);
		setenv
	}
	tzset(); /* set to system & cygwin */
}

------_=_NextPart_000_01C1BFB5.18148BB0
Content-Type: application/octet-stream;
	name="localtime.cc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="localtime.cc"
Content-length: 64381

/*=0A=
** This file is in the public domain, so clarified as of=0A=
** 1996-06-05 by Arthur David Olson (arthur_david_olson@nih.gov).=0A=
*/=0A=
/* Temporarily merged private.h and tzfile.h for ease of management - DJ */=
=0A=
=0A=
#include "winsup.h"=0A=
#include "cygerrno.h"=0A=
#include <windows.h>=0A=
#define lint=0A=
=0A=
#define USG_COMPAT=0A=
=0A=
#ifndef lint=0A=
#ifndef NOID=0A=
static char	elsieid[] =3D "@(#)localtime.c	7.66";=0A=
#endif /* !defined NOID */=0A=
#endif /* !defined lint */=0A=
=0A=
/*=0A=
** Leap second handling from Bradley White (bww@k.gp.cs.cmu.edu).=0A=
** POSIX-style TZ environment variable handling from Guy Harris=0A=
** (guy@auspex.com).=0A=
*/=0A=
=0A=
/*LINTLIBRARY*/=0A=
=0A=
#ifndef PRIVATE_H=0A=
=0A=
#define PRIVATE_H=0A=
=0A=
/*=0A=
** This file is in the public domain, so clarified as of=0A=
** 1996-06-05 by Arthur David Olson (arthur_david_olson@nih.gov).=0A=
*/=0A=
=0A=
/*=0A=
** This header is for use ONLY with the time conversion code.=0A=
** There is no guarantee that it will remain unchanged,=0A=
** or that it will remain at all.=0A=
** Do NOT copy it to any system include directory.=0A=
** Thank you!=0A=
*/=0A=
=0A=
/*=0A=
** ID=0A=
*/=0A=
=0A=
#ifndef lint=0A=
#ifndef NOID=0A=
static char	privatehid[] =3D "@(#)private.h	7.48";=0A=
#endif /* !defined NOID */=0A=
#endif /* !defined lint */=0A=
=0A=
/*=0A=
** Defaults for preprocessor symbols.=0A=
** You can override these in your C compiler options, e.g. `-DHAVE_ADJTIME=
=3D0'.=0A=
*/=0A=
=0A=
#ifndef HAVE_ADJTIME=0A=
#define HAVE_ADJTIME		1=0A=
#endif /* !defined HAVE_ADJTIME */=0A=
=0A=
#ifndef HAVE_GETTEXT=0A=
#define HAVE_GETTEXT		0=0A=
#endif /* !defined HAVE_GETTEXT */=0A=
=0A=
#ifndef HAVE_SETTIMEOFDAY=0A=
#define HAVE_SETTIMEOFDAY	3=0A=
#endif /* !defined HAVE_SETTIMEOFDAY */=0A=
=0A=
#ifndef HAVE_STRERROR=0A=
#define HAVE_STRERROR		0=0A=
#endif /* !defined HAVE_STRERROR */=0A=
=0A=
#ifndef HAVE_SYMLINK=0A=
#define HAVE_SYMLINK		1=0A=
#endif /* !defined HAVE_SYMLINK */=0A=
=0A=
#ifndef HAVE_UNISTD_H=0A=
#define HAVE_UNISTD_H		1=0A=
#endif /* !defined HAVE_UNISTD_H */=0A=
=0A=
#ifndef HAVE_UTMPX_H=0A=
#define HAVE_UTMPX_H		0=0A=
#endif /* !defined HAVE_UTMPX_H */=0A=
=0A=
#ifndef LOCALE_HOME=0A=
#define LOCALE_HOME		"/usr/lib/locale"=0A=
#endif /* !defined LOCALE_HOME */=0A=
=0A=
/*=0A=
** Nested includes=0A=
*/=0A=
=0A=
#include "sys/types.h"	/* for time_t */=0A=
#include "stdio.h"=0A=
#include "limits.h"	/* for CHAR_BIT */=0A=
#include "time.h"=0A=
#include "stdlib.h"=0A=
=0A=
#if HAVE_GETTEXT - 0=0A=
#include "libintl.h"=0A=
#endif /* HAVE_GETTEXT - 0 */=0A=
=0A=
#if HAVE_UNISTD_H - 0=0A=
#include "unistd.h"	/* for F_OK and R_OK */=0A=
#endif /* HAVE_UNISTD_H - 0 */=0A=
=0A=
#if !(HAVE_UNISTD_H - 0)=0A=
#ifndef F_OK=0A=
#define F_OK	0=0A=
#endif /* !defined F_OK */=0A=
#ifndef R_OK=0A=
#define R_OK	4=0A=
#endif /* !defined R_OK */=0A=
#endif /* !(HAVE_UNISTD_H - 0) */=0A=
=0A=
/* Unlike <ctype.h>'s isdigit, this also works if c < 0 | c > UCHAR_MAX.  *=
/=0A=
#define is_digit(c) ((unsigned)(c) - '0' <=3D 9)=0A=
=0A=
/*=0A=
** Workarounds for compilers/systems.=0A=
*/=0A=
=0A=
/*=0A=
** SunOS 4.1.1 cc lacks const.=0A=
*/=0A=
=0A=
#ifndef const=0A=
#ifndef __STDC__=0A=
#define const=0A=
#endif /* !defined __STDC__ */=0A=
#endif /* !defined const */=0A=
=0A=
/*=0A=
** SunOS 4.1.1 cc lacks prototypes.=0A=
*/=0A=
=0A=
#ifndef P=0A=
#ifdef __STDC__=0A=
#define P(x)	x=0A=
#endif /* defined __STDC__ */=0A=
#ifndef __STDC__=0A=
#define P(x)	()=0A=
#endif /* !defined __STDC__ */=0A=
#endif /* !defined P */=0A=
=0A=
/*=0A=
** SunOS 4.1.1 headers lack EXIT_SUCCESS.=0A=
*/=0A=
=0A=
#ifndef EXIT_SUCCESS=0A=
#define EXIT_SUCCESS	0=0A=
#endif /* !defined EXIT_SUCCESS */=0A=
=0A=
/*=0A=
** SunOS 4.1.1 headers lack EXIT_FAILURE.=0A=
*/=0A=
=0A=
#ifndef EXIT_FAILURE=0A=
#define EXIT_FAILURE	1=0A=
#endif /* !defined EXIT_FAILURE */=0A=
=0A=
/*=0A=
** SunOS 4.1.1 headers lack FILENAME_MAX.=0A=
*/=0A=
=0A=
#ifndef FILENAME_MAX=0A=
=0A=
#ifndef MAXPATHLEN=0A=
#ifdef unix=0A=
#include "sys/param.h"=0A=
#endif /* defined unix */=0A=
#endif /* !defined MAXPATHLEN */=0A=
=0A=
#ifdef MAXPATHLEN=0A=
#define FILENAME_MAX	MAXPATHLEN=0A=
#endif /* defined MAXPATHLEN */=0A=
#ifndef MAXPATHLEN=0A=
#define FILENAME_MAX	1024		/* Pure guesswork */=0A=
#endif /* !defined MAXPATHLEN */=0A=
=0A=
#endif /* !defined FILENAME_MAX */=0A=
=0A=
/*=0A=
** SunOS 4.1.1 libraries lack remove.=0A=
*/=0A=
=0A=
#ifndef remove=0A=
extern int	unlink P((const char * filename));=0A=
#define remove	unlink=0A=
#endif /* !defined remove */=0A=
=0A=
/*=0A=
** Finally, some convenience items.=0A=
*/=0A=
=0A=
#ifndef TRUE=0A=
#define TRUE	1=0A=
#endif /* !defined TRUE */=0A=
=0A=
#ifndef FALSE=0A=
#define FALSE	0=0A=
#endif /* !defined FALSE */=0A=
=0A=
#ifndef TYPE_BIT=0A=
#define TYPE_BIT(type)	(sizeof (type) * CHAR_BIT)=0A=
#endif /* !defined TYPE_BIT */=0A=
=0A=
#ifndef TYPE_SIGNED=0A=
#define TYPE_SIGNED(type) (((type) -1) < 0)=0A=
#endif /* !defined TYPE_SIGNED */=0A=
=0A=
#ifndef INT_STRLEN_MAXIMUM=0A=
/*=0A=
** 302 / 1000 is log10(2.0) rounded up.=0A=
** Subtract one for the sign bit if the type is signed;=0A=
** add one for integer division truncation;=0A=
** add one more for a minus sign if the type is signed.=0A=
*/=0A=
#define INT_STRLEN_MAXIMUM(type) \=0A=
    ((TYPE_BIT(type) - TYPE_SIGNED(type)) * 302 / 1000 + 1 + TYPE_SIGNED(ty=
pe))=0A=
#endif /* !defined INT_STRLEN_MAXIMUM */=0A=
=0A=
/*=0A=
** INITIALIZE(x)=0A=
*/=0A=
=0A=
#ifndef GNUC_or_lint=0A=
#ifdef lint=0A=
#define GNUC_or_lint=0A=
#endif /* defined lint */=0A=
#ifndef lint=0A=
#ifdef __GNUC__=0A=
#define GNUC_or_lint=0A=
#endif /* defined __GNUC__ */=0A=
#endif /* !defined lint */=0A=
#endif /* !defined GNUC_or_lint */=0A=
=0A=
#ifndef INITIALIZE=0A=
#ifdef GNUC_or_lint=0A=
#define INITIALIZE(x)	((x) =3D 0)=0A=
#endif /* defined GNUC_or_lint */=0A=
#ifndef GNUC_or_lint=0A=
#define INITIALIZE(x)=0A=
#endif /* !defined GNUC_or_lint */=0A=
#endif /* !defined INITIALIZE */=0A=
=0A=
/*=0A=
** For the benefit of GNU folk...=0A=
** `_(MSGID)' uses the current locale's message library string for MSGID.=
=0A=
** The default is to use gettext if available, and use MSGID otherwise.=0A=
*/=0A=
=0A=
#ifndef _=0A=
#if HAVE_GETTEXT - 0=0A=
#define _(msgid) gettext(msgid)=0A=
#else /* !(HAVE_GETTEXT - 0) */=0A=
#define _(msgid) msgid=0A=
#endif /* !(HAVE_GETTEXT - 0) */=0A=
#endif /* !defined _ */=0A=
=0A=
#ifndef TZ_DOMAIN=0A=
#define TZ_DOMAIN "tz"=0A=
#endif /* !defined TZ_DOMAIN */=0A=
=0A=
/*=0A=
** UNIX was a registered trademark of UNIX System Laboratories in 1993.=0A=
*/=0A=
=0A=
#endif /* !defined PRIVATE_H */=0A=
=0A=
#ifndef TZFILE_H=0A=
=0A=
#define TZFILE_H=0A=
=0A=
/*=0A=
** This file is in the public domain, so clarified as of=0A=
** 1996-06-05 by Arthur David Olson (arthur_david_olson@nih.gov).=0A=
*/=0A=
=0A=
/*=0A=
** This header is for use ONLY with the time conversion code.=0A=
** There is no guarantee that it will remain unchanged,=0A=
** or that it will remain at all.=0A=
** Do NOT copy it to any system include directory.=0A=
** Thank you!=0A=
*/=0A=
=0A=
/*=0A=
** ID=0A=
*/=0A=
=0A=
#ifndef lint=0A=
#ifndef NOID=0A=
static char	tzfilehid[] =3D "@(#)tzfile.h	7.14";=0A=
#endif /* !defined NOID */=0A=
#endif /* !defined lint */=0A=
=0A=
/*=0A=
** Information about time zone files.=0A=
*/=0A=
=0A=
#ifndef TZDIR=0A=
#define TZDIR	"/usr/local/etc/zoneinfo" /* Time zone object file directory =
*/=0A=
#endif /* !defined TZDIR */=0A=
=0A=
#ifndef TZDEFAULT=0A=
#define TZDEFAULT	"localtime"=0A=
#endif /* !defined TZDEFAULT */=0A=
=0A=
#ifndef TZDEFRULES=0A=
#define TZDEFRULES	"posixrules"=0A=
#endif /* !defined TZDEFRULES */=0A=
=0A=
/*=0A=
** Each file begins with. . .=0A=
*/=0A=
=0A=
#define	TZ_MAGIC	"TZif"=0A=
=0A=
struct tzhead {=0A=
	char	tzh_magic[4];		/* TZ_MAGIC */=0A=
	char	tzh_reserved[16];	/* reserved for future use */=0A=
	char	tzh_ttisgmtcnt[4];	/* coded number of trans. time flags */=0A=
	char	tzh_ttisstdcnt[4];	/* coded number of trans. time flags */=0A=
	char	tzh_leapcnt[4];		/* coded number of leap seconds */=0A=
	char	tzh_timecnt[4];		/* coded number of transition times */=0A=
	char	tzh_typecnt[4];		/* coded number of local time types */=0A=
	char	tzh_charcnt[4];		/* coded number of abbr. chars */=0A=
};=0A=
=0A=
/*=0A=
** . . .followed by. . .=0A=
**=0A=
**	tzh_timecnt (char [4])s		coded transition times a la time(2)=0A=
**	tzh_timecnt (unsigned char)s	types of local time starting at above=0A=
**	tzh_typecnt repetitions of=0A=
**		one (char [4])		coded UTC offset in seconds=0A=
**		one (unsigned char)	used to set tm_isdst=0A=
**		one (unsigned char)	that's an abbreviation list index=0A=
**	tzh_charcnt (char)s		'\0'-terminated zone abbreviations=0A=
**	tzh_leapcnt repetitions of=0A=
**		one (char [4])		coded leap second transition times=0A=
**		one (char [4])		total correction after above=0A=
**	tzh_ttisstdcnt (char)s		indexed by type; if TRUE, transition=0A=
**					time is standard time, if FALSE,=0A=
**					transition time is wall clock time=0A=
**					if absent, transition times are=0A=
**					assumed to be wall clock time=0A=
**	tzh_ttisgmtcnt (char)s		indexed by type; if TRUE, transition=0A=
**					time is UTC, if FALSE,=0A=
**					transition time is local time=0A=
**					if absent, transition times are=0A=
**					assumed to be local time=0A=
*/=0A=
=0A=
/*=0A=
** In the current implementation, "tzset()" refuses to deal with files that=
=0A=
** exceed any of the limits below.=0A=
*/=0A=
=0A=
#ifndef TZ_MAX_TIMES=0A=
/*=0A=
** The TZ_MAX_TIMES value below is enough to handle a bit more than a=0A=
** year's worth of solar time (corrected daily to the nearest second) or=0A=
** 138 years of Pacific Presidential Election time=0A=
** (where there are three time zone transitions every fourth year).=0A=
*/=0A=
#define TZ_MAX_TIMES	370=0A=
#endif /* !defined TZ_MAX_TIMES */=0A=
=0A=
#ifndef TZ_MAX_TYPES=0A=
#ifndef NOSOLAR=0A=
#define TZ_MAX_TYPES	256 /* Limited by what (unsigned char)'s can hold */=
=0A=
#endif /* !defined NOSOLAR */=0A=
#ifdef NOSOLAR=0A=
/*=0A=
** Must be at least 14 for Europe/Riga as of Jan 12 1995,=0A=
** as noted by Earl Chew <earl@hpato.aus.hp.com>.=0A=
*/=0A=
#define TZ_MAX_TYPES	20	/* Maximum number of local time types */=0A=
#endif /* !defined NOSOLAR */=0A=
#endif /* !defined TZ_MAX_TYPES */=0A=
=0A=
#ifndef TZ_MAX_CHARS=0A=
#define TZ_MAX_CHARS	50	/* Maximum number of abbreviation characters */=0A=
				/* (limited by what unsigned chars can hold) */=0A=
#endif /* !defined TZ_MAX_CHARS */=0A=
=0A=
#ifndef TZ_MAX_LEAPS=0A=
#define TZ_MAX_LEAPS	50	/* Maximum number of leap second corrections */=0A=
#endif /* !defined TZ_MAX_LEAPS */=0A=
=0A=
#define SECSPERMIN	60=0A=
#define MINSPERHOUR	60=0A=
#define HOURSPERDAY	24=0A=
#define DAYSPERWEEK	7=0A=
#define DAYSPERNYEAR	365=0A=
#define DAYSPERLYEAR	366=0A=
#define SECSPERHOUR	(SECSPERMIN * MINSPERHOUR)=0A=
#define SECSPERDAY	((long) SECSPERHOUR * HOURSPERDAY)=0A=
#define MONSPERYEAR	12=0A=
=0A=
#define TM_SUNDAY	0=0A=
#define TM_MONDAY	1=0A=
#define TM_TUESDAY	2=0A=
#define TM_WEDNESDAY	3=0A=
#define TM_THURSDAY	4=0A=
#define TM_FRIDAY	5=0A=
#define TM_SATURDAY	6=0A=
=0A=
#define TM_JANUARY	0=0A=
#define TM_FEBRUARY	1=0A=
#define TM_MARCH	2=0A=
#define TM_APRIL	3=0A=
#define TM_MAY		4=0A=
#define TM_JUNE		5=0A=
#define TM_JULY		6=0A=
#define TM_AUGUST	7=0A=
#define TM_SEPTEMBER	8=0A=
#define TM_OCTOBER	9=0A=
#define TM_NOVEMBER	10=0A=
#define TM_DECEMBER	11=0A=
=0A=
#define TM_YEAR_BASE	1900=0A=
=0A=
#define EPOCH_YEAR	1970=0A=
#define EPOCH_WDAY	TM_THURSDAY=0A=
=0A=
/*=0A=
** Accurate only for the past couple of centuries;=0A=
** that will probably do.=0A=
*/=0A=
=0A=
#define isleap(y) (((y) % 4) =3D=3D 0 && (((y) % 100) !=3D 0 || ((y) % 400)=
 =3D=3D 0))=0A=
=0A=
#ifndef USG=0A=
=0A=
/*=0A=
** Use of the underscored variants may cause problems if you move your code=
 to=0A=
** certain System-V-based systems; for maximum portability, use the=0A=
** underscore-free variants.  The underscored variants are provided for=0A=
** backward compatibility only; they may disappear from future versions of=
=0A=
** this file.=0A=
*/=0A=
=0A=
#define SECS_PER_MIN	SECSPERMIN=0A=
#define MINS_PER_HOUR	MINSPERHOUR=0A=
#define HOURS_PER_DAY	HOURSPERDAY=0A=
#define DAYS_PER_WEEK	DAYSPERWEEK=0A=
#define DAYS_PER_NYEAR	DAYSPERNYEAR=0A=
#define DAYS_PER_LYEAR	DAYSPERLYEAR=0A=
#define SECS_PER_HOUR	SECSPERHOUR=0A=
#define SECS_PER_DAY	SECSPERDAY=0A=
#define MONS_PER_YEAR	MONSPERYEAR=0A=
=0A=
#endif /* !defined USG */=0A=
=0A=
#endif /* !defined TZFILE_H */=0A=
=0A=
#include "fcntl.h"=0A=
=0A=
/*=0A=
** SunOS 4.1.1 headers lack O_BINARY.=0A=
*/=0A=
=0A=
#ifdef O_BINARY=0A=
#define OPEN_MODE	(O_RDONLY | O_BINARY)=0A=
#endif /* defined O_BINARY */=0A=
#ifndef O_BINARY=0A=
#define OPEN_MODE	O_RDONLY=0A=
#endif /* !defined O_BINARY */=0A=
=0A=
#ifndef WILDABBR=0A=
/*=0A=
** Someone might make incorrect use of a time zone abbreviation:=0A=
**	1.	They might reference tzname[0] before calling tzset (explicitly=0A=
**		or implicitly).=0A=
**	2.	They might reference tzname[1] before calling tzset (explicitly=0A=
**		or implicitly).=0A=
**	3.	They might reference tzname[1] after setting to a time zone=0A=
**		in which Daylight Saving Time is never observed.=0A=
**	4.	They might reference tzname[0] after setting to a time zone=0A=
**		in which Standard Time is never observed.=0A=
**	5.	They might reference tm.TM_ZONE after calling offtime.=0A=
** What's best to do in the above cases is open to debate;=0A=
** for now, we just set things up so that in any of the five cases=0A=
** WILDABBR is used.  Another possibility:  initialize tzname[0] to the=0A=
** string "tzname[0] used before set", and similarly for the other cases.=
=0A=
** And another:  initialize tzname[0] to "ERA", with an explanation in the=
=0A=
** manual page of what this "time zone abbreviation" means (doing this so=
=0A=
** that tzname[0] has the "normal" length of three characters).=0A=
*/=0A=
#define WILDABBR	"   "=0A=
#endif /* !defined WILDABBR */=0A=
=0A=
static char wildabbr[] NO_COPY =3D WILDABBR;=0A=
=0A=
static char gmt[] NO_COPY =3D "GMT";=0A=
=0A=
struct ttinfo {				/* time type information */=0A=
	long		tt_gmtoff;	/* UTC offset in seconds */=0A=
	int		tt_isdst;	/* used to set tm_isdst */=0A=
	int		tt_abbrind;	/* abbreviation list index */=0A=
	int		tt_ttisstd;	/* TRUE if transition is std time */=0A=
	int		tt_ttisgmt;	/* TRUE if transition is UTC */=0A=
};=0A=
=0A=
struct lsinfo {				/* leap second information */=0A=
	time_t		ls_trans;	/* transition time */=0A=
	long		ls_corr;	/* correction to apply */=0A=
};=0A=
=0A=
#define BIGGEST(a, b)	(((a) > (b)) ? (a) : (b))=0A=
=0A=
#ifdef TZNAME_MAX=0A=
#define MY_TZNAME_MAX	TZNAME_MAX=0A=
#endif /* defined TZNAME_MAX */=0A=
#ifndef TZNAME_MAX=0A=
#define MY_TZNAME_MAX	255=0A=
#endif /* !defined TZNAME_MAX */=0A=
=0A=
struct state {=0A=
	int		leapcnt;=0A=
	int		timecnt;=0A=
	int		typecnt;=0A=
	int		charcnt;=0A=
	time_t		ats[TZ_MAX_TIMES];=0A=
	unsigned char	types[TZ_MAX_TIMES];=0A=
	struct ttinfo	ttis[TZ_MAX_TYPES];=0A=
	char		chars[BIGGEST(BIGGEST(TZ_MAX_CHARS + 1, sizeof gmt),=0A=
				(2 * (MY_TZNAME_MAX + 1)))];=0A=
	struct lsinfo	lsis[TZ_MAX_LEAPS];=0A=
};=0A=
=0A=
struct rule {=0A=
	int		r_type;		/* type of rule--see below */=0A=
	int		r_day;		/* day number of rule */=0A=
	int		r_week;		/* week number of rule */=0A=
	int		r_mon;		/* month number of rule */=0A=
	long		r_time;		/* transition time of rule */=0A=
};=0A=
=0A=
#define JULIAN_DAY		0	/* Jn - Julian day */=0A=
#define DAY_OF_YEAR		1	/* n - day of year */=0A=
#define MONTH_NTH_DAY_OF_WEEK	2	/* Mm.n.d - month, week, day of week */=0A=
=0A=
/*=0A=
** Prototypes for static functions.=0A=
*/=0A=
=0A=
static long		detzcode P((const char * codep));=0A=
static const char *	getzname P((const char * strp));=0A=
static const char *	getnum P((const char * strp, int * nump, int min,=0A=
				int max));=0A=
static const char *	getsecs P((const char * strp, long * secsp));=0A=
static const char *	getoffset P((const char * strp, long * offsetp));=0A=
static const char *	getrule P((const char * strp, struct rule * rulep));=0A=
static void		gmtload P((struct state * sp));=0A=
static void		gmtsub P((const time_t * timep, long offset,=0A=
				struct tm * tmp));=0A=
static void		localsub P((const time_t * timep, long offset,=0A=
				struct tm * tmp));=0A=
static int		increment_overflow P((int * number, int delta));=0A=
static int		normalize_overflow P((int * tensptr, int * unitsptr,=0A=
				int base));=0A=
static void		settzname P((void));=0A=
static time_t		time1 P((struct tm * tmp,=0A=
				void(*funcp) P((const time_t *,=0A=
				long, struct tm *)),=0A=
				long offset));=0A=
static time_t		time2 P((struct tm *tmp,=0A=
				void(*funcp) P((const time_t *,=0A=
				long, struct tm*)),=0A=
				long offset, int * okayp));=0A=
static time_t		time2sub P((struct tm *tmp,=0A=
				void(*funcp) P((const time_t *,=0A=
				long, struct tm*)),=0A=
				long offset, int * okayp, int do_norm_secs));=0A=
static void		timesub P((const time_t * timep, long offset,=0A=
				const struct state * sp, struct tm * tmp));=0A=
static int		tmcomp P((const struct tm * atmp,=0A=
				const struct tm * btmp));=0A=
static time_t		transtime P((time_t janfirst, int year,=0A=
				const struct rule * rulep, long offset));=0A=
static int		tzload P((const char * name, struct state * sp));=0A=
static int		tzparse P((const char * name, struct state * sp,=0A=
				int lastditch));=0A=
=0A=
#ifdef ALL_STATE=0A=
static struct state *	lclptr;=0A=
static struct state *	gmtptr;=0A=
#endif /* defined ALL_STATE */=0A=
=0A=
#ifndef ALL_STATE=0A=
static struct state	lclmem;=0A=
static struct state	gmtmem;=0A=
#define lclptr		(&lclmem)=0A=
#define gmtptr		(&gmtmem)=0A=
#endif /* State Farm */=0A=
=0A=
#ifndef TZ_STRLEN_MAX=0A=
#define TZ_STRLEN_MAX 255=0A=
#endif /* !defined TZ_STRLEN_MAX */=0A=
=0A=
static char		lcl_TZname[TZ_STRLEN_MAX + 1];=0A=
static int		lcl_is_set;=0A=
static int		gmt_is_set;=0A=
=0A=
#define tzname _tzname=0A=
#undef _tzname=0A=
=0A=
char *	tzname[2] =3D {=0A=
	wildabbr,=0A=
	wildabbr=0A=
};=0A=
=0A=
/*=0A=
** Section 4.12.3 of X3.159-1989 requires that=0A=
**	Except for the strftime function, these functions [asctime,=0A=
**	ctime, gmtime, localtime] return values in one of two static=0A=
**	objects: a broken-down time structure and an array of char.=0A=
** Thanks to Paul Eggert (eggert@twinsun.com) for noting this.=0A=
*/=0A=
=0A=
static struct tm	tm;=0A=
=0A=
=0A=
/* These variables are initialized by tzset.  The macro versions are=0A=
   defined in time.h, and indirect through the __imp_ pointers.  */=0A=
=0A=
#define timezone _timezone=0A=
#define daylight _daylight=0A=
#undef _timezone=0A=
#undef _daylight=0A=
=0A=
#ifdef USG_COMPAT=0A=
time_t			timezone;=0A=
int			daylight;=0A=
#endif /* defined USG_COMPAT */=0A=
=0A=
#ifdef ALTZONE=0A=
time_t			altzone;=0A=
#endif /* defined ALTZONE */=0A=
=0A=
static long=0A=
detzcode(const char *codep)=0A=
{=0A=
	register long	result;=0A=
	register int	i;=0A=
=0A=
	result =3D (codep[0] & 0x80) ? ~0L : 0L;=0A=
	for (i =3D 0; i < 4; ++i)=0A=
		result =3D (result << 8) | (codep[i] & 0xff);=0A=
	return result;=0A=
}=0A=
=0A=
static void=0A=
settzname P((void))=0A=
{=0A=
	register struct state * const	sp =3D lclptr;=0A=
	register int			i;=0A=
=0A=
	tzname[0] =3D wildabbr;=0A=
	tzname[1] =3D wildabbr;=0A=
#ifdef USG_COMPAT=0A=
	daylight =3D 0;=0A=
	timezone =3D 0;=0A=
#endif /* defined USG_COMPAT */=0A=
#ifdef ALTZONE=0A=
	altzone =3D 0;=0A=
#endif /* defined ALTZONE */=0A=
#ifdef ALL_STATE=0A=
	if (sp =3D=3D NULL) {=0A=
		tzname[0] =3D tzname[1] =3D gmt;=0A=
		return;=0A=
	}=0A=
#endif /* defined ALL_STATE */=0A=
	for (i =3D 0; i < sp->typecnt; ++i) {=0A=
		register const struct ttinfo * const	ttisp =3D &sp->ttis[i];=0A=
=0A=
		tzname[ttisp->tt_isdst] =3D=0A=
			&sp->chars[ttisp->tt_abbrind];=0A=
#ifdef USG_COMPAT=0A=
		if (ttisp->tt_isdst)=0A=
			daylight =3D 1;=0A=
		if (i =3D=3D 0 || !ttisp->tt_isdst)=0A=
			timezone =3D -(ttisp->tt_gmtoff);=0A=
#endif /* defined USG_COMPAT */=0A=
#ifdef ALTZONE=0A=
		if (i =3D=3D 0 || ttisp->tt_isdst)=0A=
			altzone =3D -(ttisp->tt_gmtoff);=0A=
#endif /* defined ALTZONE */=0A=
	}=0A=
	/*=0A=
	** And to get the latest zone names into tzname. . .=0A=
	*/=0A=
	for (i =3D 0; i < sp->timecnt; ++i) {=0A=
		register const struct ttinfo * const	ttisp =3D=0A=
							&sp->ttis[=0A=
								sp->types[i]];=0A=
=0A=
		tzname[ttisp->tt_isdst] =3D=0A=
			&sp->chars[ttisp->tt_abbrind];=0A=
	}=0A=
}=0A=
=0A=
#include "tz_posixrules.h"=0A=
=0A=
static int=0A=
tzload(const char *name, struct state *sp)=0A=
{=0A=
	register const char *	p;=0A=
	register int		i;=0A=
	register int		fid;=0A=
	save_errno		save;=0A=
=0A=
	if (name =3D=3D NULL && (name =3D TZDEFAULT) =3D=3D NULL)=0A=
		return -1;=0A=
	{=0A=
		register int	doaccess;=0A=
		/*=0A=
		** Section 4.9.1 of the C standard says that=0A=
		** "FILENAME_MAX expands to an integral constant expression=0A=
		** that is the size needed for an array of char large enough=0A=
		** to hold the longest file name string that the implementation=0A=
		** guarantees can be opened."=0A=
		*/=0A=
		char		fullname[FILENAME_MAX + 1];=0A=
=0A=
		if (name[0] =3D=3D ':')=0A=
			++name;=0A=
		doaccess =3D name[0] =3D=3D '/';=0A=
		if (!doaccess) {=0A=
			if ((p =3D TZDIR) =3D=3D NULL)=0A=
				return -1;=0A=
			if ((strlen(p) + strlen(name) + 1) >=3D sizeof fullname)=0A=
				return -1;=0A=
			(void) strcpy(fullname, p);=0A=
			(void) strcat(fullname, "/");=0A=
			(void) strcat(fullname, name);=0A=
			/*=0A=
			** Set doaccess if '.' (as in "../") shows up in name.=0A=
			*/=0A=
			if (strchr(name, '.') !=3D NULL)=0A=
				doaccess =3D TRUE;=0A=
			name =3D fullname;=0A=
		}=0A=
#if 0=0A=
		if (doaccess && access(name, R_OK) !=3D 0)=0A=
			return -1;=0A=
#endif=0A=
		if ((fid =3D open(name, OPEN_MODE)) =3D=3D -1)=0A=
		  {=0A=
		    const char *base =3D strrchr(name, '/');=0A=
		    if (base)=0A=
		      base++;=0A=
		    else=0A=
		      base =3D name;=0A=
		    if (strcmp(base, "posixrules"))=0A=
		      return -1;=0A=
=0A=
		    /* We've got a built-in copy of posixrules just in case */=0A=
		    fid =3D -2;=0A=
		  }=0A=
	}=0A=
	{=0A=
		struct tzhead *	tzhp;=0A=
		union {=0A=
		  struct tzhead tzhead;=0A=
		  char		buf[sizeof *sp + sizeof *tzhp];=0A=
		} u;=0A=
		int		ttisstdcnt;=0A=
		int		ttisgmtcnt;=0A=
=0A=
		if (fid =3D=3D -2)=0A=
		  {=0A=
		    memcpy(u.buf, _posixrules_data, sizeof(_posixrules_data));=0A=
		    i =3D sizeof(_posixrules_data);=0A=
		  }=0A=
		else=0A=
		  {=0A=
		    i =3D read(fid, u.buf, sizeof u.buf);=0A=
		    if (close(fid) !=3D 0)=0A=
			return -1;=0A=
		  }=0A=
		ttisstdcnt =3D (int) detzcode(u.tzhead.tzh_ttisgmtcnt);=0A=
		ttisgmtcnt =3D (int) detzcode(u.tzhead.tzh_ttisstdcnt);=0A=
		sp->leapcnt =3D (int) detzcode(u.tzhead.tzh_leapcnt);=0A=
		sp->timecnt =3D (int) detzcode(u.tzhead.tzh_timecnt);=0A=
		sp->typecnt =3D (int) detzcode(u.tzhead.tzh_typecnt);=0A=
		sp->charcnt =3D (int) detzcode(u.tzhead.tzh_charcnt);=0A=
		p =3D u.tzhead.tzh_charcnt + sizeof u.tzhead.tzh_charcnt;=0A=
		if (sp->leapcnt < 0 || sp->leapcnt > TZ_MAX_LEAPS ||=0A=
			sp->typecnt <=3D 0 || sp->typecnt > TZ_MAX_TYPES ||=0A=
			sp->timecnt < 0 || sp->timecnt > TZ_MAX_TIMES ||=0A=
			sp->charcnt < 0 || sp->charcnt > TZ_MAX_CHARS ||=0A=
			(ttisstdcnt !=3D sp->typecnt && ttisstdcnt !=3D 0) ||=0A=
			(ttisgmtcnt !=3D sp->typecnt && ttisgmtcnt !=3D 0))=0A=
				return -1;=0A=
		if (i - (p - u.buf) < sp->timecnt * 4 +	/* ats */=0A=
			sp->timecnt +			/* types */=0A=
			sp->typecnt * (4 + 2) +		/* ttinfos */=0A=
			sp->charcnt +			/* chars */=0A=
			sp->leapcnt * (4 + 4) +		/* lsinfos */=0A=
			ttisstdcnt +			/* ttisstds */=0A=
			ttisgmtcnt)			/* ttisgmts */=0A=
				return -1;=0A=
		for (i =3D 0; i < sp->timecnt; ++i) {=0A=
			sp->ats[i] =3D detzcode(p);=0A=
			p +=3D 4;=0A=
		}=0A=
		for (i =3D 0; i < sp->timecnt; ++i) {=0A=
			sp->types[i] =3D (unsigned char) *p++;=0A=
			if (sp->types[i] >=3D sp->typecnt)=0A=
				return -1;=0A=
		}=0A=
		for (i =3D 0; i < sp->typecnt; ++i) {=0A=
			register struct ttinfo *	ttisp;=0A=
=0A=
			ttisp =3D &sp->ttis[i];=0A=
			ttisp->tt_gmtoff =3D detzcode(p);=0A=
			p +=3D 4;=0A=
			ttisp->tt_isdst =3D (unsigned char) *p++;=0A=
			if (ttisp->tt_isdst !=3D 0 && ttisp->tt_isdst !=3D 1)=0A=
				return -1;=0A=
			ttisp->tt_abbrind =3D (unsigned char) *p++;=0A=
			if (ttisp->tt_abbrind < 0 ||=0A=
				ttisp->tt_abbrind > sp->charcnt)=0A=
					return -1;=0A=
		}=0A=
		for (i =3D 0; i < sp->charcnt; ++i)=0A=
			sp->chars[i] =3D *p++;=0A=
		sp->chars[i] =3D '\0';	/* ensure '\0' at end */=0A=
		for (i =3D 0; i < sp->leapcnt; ++i) {=0A=
			register struct lsinfo *	lsisp;=0A=
=0A=
			lsisp =3D &sp->lsis[i];=0A=
			lsisp->ls_trans =3D detzcode(p);=0A=
			p +=3D 4;=0A=
			lsisp->ls_corr =3D detzcode(p);=0A=
			p +=3D 4;=0A=
		}=0A=
		for (i =3D 0; i < sp->typecnt; ++i) {=0A=
			register struct ttinfo *	ttisp;=0A=
=0A=
			ttisp =3D &sp->ttis[i];=0A=
			if (ttisstdcnt =3D=3D 0)=0A=
				ttisp->tt_ttisstd =3D FALSE;=0A=
			else {=0A=
				ttisp->tt_ttisstd =3D *p++;=0A=
				if (ttisp->tt_ttisstd !=3D TRUE &&=0A=
					ttisp->tt_ttisstd !=3D FALSE)=0A=
						return -1;=0A=
			}=0A=
		}=0A=
		for (i =3D 0; i < sp->typecnt; ++i) {=0A=
			register struct ttinfo *	ttisp;=0A=
=0A=
			ttisp =3D &sp->ttis[i];=0A=
			if (ttisgmtcnt =3D=3D 0)=0A=
				ttisp->tt_ttisgmt =3D FALSE;=0A=
			else {=0A=
				ttisp->tt_ttisgmt =3D *p++;=0A=
				if (ttisp->tt_ttisgmt !=3D TRUE &&=0A=
					ttisp->tt_ttisgmt !=3D FALSE)=0A=
						return -1;=0A=
			}=0A=
		}=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
static const int	mon_lengths[2][MONSPERYEAR] =3D {=0A=
	{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },=0A=
	{ 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }=0A=
};=0A=
=0A=
static const int	year_lengths[2] =3D {=0A=
	DAYSPERNYEAR, DAYSPERLYEAR=0A=
};=0A=
=0A=
/*=0A=
** Given a pointer into a time zone string, scan until a character that is =
not=0A=
** a valid character in a zone name is found.  Return a pointer to that=0A=
** character.=0A=
*/=0A=
=0A=
static const char *=0A=
getzname(const char *strp)=0A=
{=0A=
	register char	c;=0A=
=0A=
	while ((c =3D *strp) !=3D '\0' && !is_digit(c) && c !=3D ',' && c !=3D '-'=
 &&=0A=
		c !=3D '+')=0A=
			++strp;=0A=
	return strp;=0A=
}=0A=
=0A=
/*=0A=
** Given a pointer into a time zone string, extract a number from that stri=
ng.=0A=
** Check that the number is within a specified range; if it is not, return=
=0A=
** NULL.=0A=
** Otherwise, return a pointer to the first character not part of the numbe=
r.=0A=
*/=0A=
=0A=
static const char *=0A=
getnum(const char *strp, int *nump, const int min, const int max)=0A=
{=0A=
	register char	c;=0A=
	register int	num;=0A=
=0A=
	if (strp =3D=3D NULL || !is_digit(c =3D *strp))=0A=
		return NULL;=0A=
	num =3D 0;=0A=
	do {=0A=
		num =3D num * 10 + (c - '0');=0A=
		if (num > max)=0A=
			return NULL;	/* illegal value */=0A=
		c =3D *++strp;=0A=
	} while (is_digit(c));=0A=
	if (num < min)=0A=
		return NULL;		/* illegal value */=0A=
	*nump =3D num;=0A=
	return strp;=0A=
}=0A=
=0A=
/*=0A=
** Given a pointer into a time zone string, extract a number of seconds,=0A=
** in hh[:mm[:ss]] form, from the string.=0A=
** If any error occurs, return NULL.=0A=
** Otherwise, return a pointer to the first character not part of the numbe=
r=0A=
** of seconds.=0A=
*/=0A=
=0A=
static const char *=0A=
getsecs(const char *strp, long *secsp)=0A=
{=0A=
	int	num;=0A=
=0A=
	/*=0A=
	** `HOURSPERDAY * DAYSPERWEEK - 1' allows quasi-Posix rules like=0A=
	** "M10.4.6/26", which does not conform to Posix,=0A=
	** but which specifies the equivalent of=0A=
	** ``02:00 on the first Sunday on or after 23 Oct''.=0A=
	*/=0A=
	strp =3D getnum(strp, &num, 0, HOURSPERDAY * DAYSPERWEEK - 1);=0A=
	if (strp =3D=3D NULL)=0A=
		return NULL;=0A=
	*secsp =3D num * (long) SECSPERHOUR;=0A=
	if (*strp =3D=3D ':') {=0A=
		++strp;=0A=
		strp =3D getnum(strp, &num, 0, MINSPERHOUR - 1);=0A=
		if (strp =3D=3D NULL)=0A=
			return NULL;=0A=
		*secsp +=3D num * SECSPERMIN;=0A=
		if (*strp =3D=3D ':') {=0A=
			++strp;=0A=
			/* `SECSPERMIN' allows for leap seconds.  */=0A=
			strp =3D getnum(strp, &num, 0, SECSPERMIN);=0A=
			if (strp =3D=3D NULL)=0A=
				return NULL;=0A=
			*secsp +=3D num;=0A=
		}=0A=
	}=0A=
	return strp;=0A=
}=0A=
=0A=
/*=0A=
** Given a pointer into a time zone string, extract an offset, in=0A=
** [+-]hh[:mm[:ss]] form, from the string.=0A=
** If any error occurs, return NULL.=0A=
** Otherwise, return a pointer to the first character not part of the time.=
=0A=
*/=0A=
=0A=
static const char *=0A=
getoffset(const char *strp, long *offsetp)=0A=
{=0A=
	register int	neg =3D 0;=0A=
=0A=
	if (*strp =3D=3D '-') {=0A=
		neg =3D 1;=0A=
		++strp;=0A=
	} else if (*strp =3D=3D '+')=0A=
		++strp;=0A=
	strp =3D getsecs(strp, offsetp);=0A=
	if (strp =3D=3D NULL)=0A=
		return NULL;		/* illegal time */=0A=
	if (neg)=0A=
		*offsetp =3D -*offsetp;=0A=
	return strp;=0A=
}=0A=
=0A=
/*=0A=
** Given a pointer into a time zone string, extract a rule in the form=0A=
** date[/time].  See POSIX section 8 for the format of "date" and "time".=
=0A=
** If a valid rule is not found, return NULL.=0A=
** Otherwise, return a pointer to the first character not part of the rule.=
=0A=
*/=0A=
=0A=
static const char *=0A=
getrule(const char *strp, struct rule *rulep)=0A=
{=0A=
	if (*strp =3D=3D 'J') {=0A=
		/*=0A=
		** Julian day.=0A=
		*/=0A=
		rulep->r_type =3D JULIAN_DAY;=0A=
		++strp;=0A=
		strp =3D getnum(strp, &rulep->r_day, 1, DAYSPERNYEAR);=0A=
	} else if (*strp =3D=3D 'M') {=0A=
		/*=0A=
		** Month, week, day.=0A=
		*/=0A=
		rulep->r_type =3D MONTH_NTH_DAY_OF_WEEK;=0A=
		++strp;=0A=
		strp =3D getnum(strp, &rulep->r_mon, 1, MONSPERYEAR);=0A=
		if (strp =3D=3D NULL)=0A=
			return NULL;=0A=
		if (*strp++ !=3D '.')=0A=
			return NULL;=0A=
		strp =3D getnum(strp, &rulep->r_week, 1, 5);=0A=
		if (strp =3D=3D NULL)=0A=
			return NULL;=0A=
		if (*strp++ !=3D '.')=0A=
			return NULL;=0A=
		strp =3D getnum(strp, &rulep->r_day, 0, DAYSPERWEEK - 1);=0A=
	} else if (is_digit(*strp)) {=0A=
		/*=0A=
		** Day of year.=0A=
		*/=0A=
		rulep->r_type =3D DAY_OF_YEAR;=0A=
		strp =3D getnum(strp, &rulep->r_day, 0, DAYSPERLYEAR - 1);=0A=
	} else	return NULL;		/* invalid format */=0A=
	if (strp =3D=3D NULL)=0A=
		return NULL;=0A=
	if (*strp =3D=3D '/') {=0A=
		/*=0A=
		** Time specified.=0A=
		*/=0A=
		++strp;=0A=
		strp =3D getsecs(strp, &rulep->r_time);=0A=
	} else	rulep->r_time =3D 2 * SECSPERHOUR;	/* default =3D 2:00:00 */=0A=
	return strp;=0A=
}=0A=
=0A=
/*=0A=
** Given the Epoch-relative time of January 1, 00:00:00 UTC, in a year, the=
=0A=
** year, a rule, and the offset from UTC at the time that rule takes effect=
,=0A=
** calculate the Epoch-relative time that rule takes effect.=0A=
*/=0A=
=0A=
static time_t=0A=
transtime(const time_t janfirst, const int year, const struct rule *rulep,=
=0A=
		long offset)=0A=
{=0A=
	register int	leapyear;=0A=
	register time_t	value;=0A=
	register int	i;=0A=
	int		d, m1, yy0, yy1, yy2, dow;=0A=
=0A=
	INITIALIZE(value);=0A=
	leapyear =3D isleap(year);=0A=
	switch (rulep->r_type) {=0A=
=0A=
	case JULIAN_DAY:=0A=
		/*=0A=
		** Jn - Julian day, 1 =3D=3D January 1, 60 =3D=3D March 1 even in leap=0A=
		** years.=0A=
		** In non-leap years, or if the day number is 59 or less, just=0A=
		** add SECSPERDAY times the day number-1 to the time of=0A=
		** January 1, midnight, to get the day.=0A=
		*/=0A=
		value =3D janfirst + (rulep->r_day - 1) * SECSPERDAY;=0A=
		if (leapyear && rulep->r_day >=3D 60)=0A=
			value +=3D SECSPERDAY;=0A=
		break;=0A=
=0A=
	case DAY_OF_YEAR:=0A=
		/*=0A=
		** n - day of year.=0A=
		** Just add SECSPERDAY times the day number to the time of=0A=
		** January 1, midnight, to get the day.=0A=
		*/=0A=
		value =3D janfirst + rulep->r_day * SECSPERDAY;=0A=
		break;=0A=
=0A=
	case MONTH_NTH_DAY_OF_WEEK:=0A=
		/*=0A=
		** Mm.n.d - nth "dth day" of month m.=0A=
		*/=0A=
		value =3D janfirst;=0A=
		for (i =3D 0; i < rulep->r_mon - 1; ++i)=0A=
			value +=3D mon_lengths[leapyear][i] * SECSPERDAY;=0A=
=0A=
		/*=0A=
		** Use Zeller's Congruence to get day-of-week of first day of=0A=
		** month.=0A=
		*/=0A=
		m1 =3D (rulep->r_mon + 9) % 12 + 1;=0A=
		yy0 =3D (rulep->r_mon <=3D 2) ? (year - 1) : year;=0A=
		yy1 =3D yy0 / 100;=0A=
		yy2 =3D yy0 % 100;=0A=
		dow =3D ((26 * m1 - 2) / 10 +=0A=
			1 + yy2 + yy2 / 4 + yy1 / 4 - 2 * yy1) % 7;=0A=
		if (dow < 0)=0A=
			dow +=3D DAYSPERWEEK;=0A=
=0A=
		/*=0A=
		** "dow" is the day-of-week of the first day of the month.  Get=0A=
		** the day-of-month (zero-origin) of the first "dow" day of the=0A=
		** month.=0A=
		*/=0A=
		d =3D rulep->r_day - dow;=0A=
		if (d < 0)=0A=
			d +=3D DAYSPERWEEK;=0A=
		for (i =3D 1; i < rulep->r_week; ++i) {=0A=
			if (d + DAYSPERWEEK >=3D=0A=
				mon_lengths[leapyear][rulep->r_mon - 1])=0A=
					break;=0A=
			d +=3D DAYSPERWEEK;=0A=
		}=0A=
=0A=
		/*=0A=
		** "d" is the day-of-month (zero-origin) of the day we want.=0A=
		*/=0A=
		value +=3D d * SECSPERDAY;=0A=
		break;=0A=
	}=0A=
=0A=
	/*=0A=
	** "value" is the Epoch-relative time of 00:00:00 UTC on the day in=0A=
	** question.  To get the Epoch-relative time of the specified local=0A=
	** time on that day, add the transition time and the current offset=0A=
	** from UTC.=0A=
	*/=0A=
	return value + rulep->r_time + offset;=0A=
}=0A=
=0A=
/*=0A=
** Given a POSIX section 8-style TZ string, fill in the rule tables as=0A=
** appropriate.=0A=
*/=0A=
=0A=
static int=0A=
tzparse(const char *name, struct state *sp, const int lastditch)=0A=
{=0A=
	const char *			stdname;=0A=
	const char *			dstname;=0A=
	size_t				stdlen;=0A=
	size_t				dstlen;=0A=
	long				stdoffset;=0A=
	long				dstoffset;=0A=
	register time_t *		atp;=0A=
	register unsigned char *	typep;=0A=
	register char *			cp;=0A=
	register int			load_result;=0A=
=0A=
	INITIALIZE(dstname);=0A=
	stdname =3D name;=0A=
	if (lastditch) {=0A=
		stdlen =3D strlen(name);	/* length of standard zone name */=0A=
		name +=3D stdlen;=0A=
		if (stdlen >=3D sizeof sp->chars)=0A=
			stdlen =3D (sizeof sp->chars) - 1;=0A=
		stdoffset =3D 0;=0A=
	} else {=0A=
		name =3D getzname(name);=0A=
		stdlen =3D name - stdname;=0A=
		if (stdlen < 3)=0A=
			return -1;=0A=
		if (*name =3D=3D '\0')=0A=
			return -1;=0A=
		name =3D getoffset(name, &stdoffset);=0A=
		if (name =3D=3D NULL)=0A=
			return -1;=0A=
	}=0A=
	load_result =3D tzload(TZDEFRULES, sp);=0A=
	if (load_result !=3D 0)=0A=
		sp->leapcnt =3D 0;		/* so, we're off a little */=0A=
	if (*name !=3D '\0') {=0A=
		dstname =3D name;=0A=
		name =3D getzname(name);=0A=
		dstlen =3D name - dstname;	/* length of DST zone name */=0A=
		if (dstlen < 3)=0A=
			return -1;=0A=
		if (*name !=3D '\0' && *name !=3D ',' && *name !=3D ';') {=0A=
			name =3D getoffset(name, &dstoffset);=0A=
			if (name =3D=3D NULL)=0A=
				return -1;=0A=
		} else	dstoffset =3D stdoffset - SECSPERHOUR;=0A=
		if (*name =3D=3D ',' || *name =3D=3D ';') {=0A=
			struct rule	start;=0A=
			struct rule	end;=0A=
			register int	year;=0A=
			register time_t	janfirst;=0A=
			time_t		starttime;=0A=
			time_t		endtime;=0A=
=0A=
			++name;=0A=
			if ((name =3D getrule(name, &start)) =3D=3D NULL)=0A=
				return -1;=0A=
			if (*name++ !=3D ',')=0A=
				return -1;=0A=
			if ((name =3D getrule(name, &end)) =3D=3D NULL)=0A=
				return -1;=0A=
			if (*name !=3D '\0')=0A=
				return -1;=0A=
			sp->typecnt =3D 2;	/* standard time and DST */=0A=
			/*=0A=
			** Two transitions per year, from EPOCH_YEAR to 2037.=0A=
			*/=0A=
			sp->timecnt =3D 2 * (2037 - EPOCH_YEAR + 1);=0A=
			if (sp->timecnt > TZ_MAX_TIMES)=0A=
				return -1;=0A=
			sp->ttis[0].tt_gmtoff =3D -dstoffset;=0A=
			sp->ttis[0].tt_isdst =3D 1;=0A=
			sp->ttis[0].tt_abbrind =3D stdlen + 1;=0A=
			sp->ttis[1].tt_gmtoff =3D -stdoffset;=0A=
			sp->ttis[1].tt_isdst =3D 0;=0A=
			sp->ttis[1].tt_abbrind =3D 0;=0A=
			atp =3D sp->ats;=0A=
			typep =3D sp->types;=0A=
			janfirst =3D 0;=0A=
			for (year =3D EPOCH_YEAR; year <=3D 2037; ++year) {=0A=
				starttime =3D transtime(janfirst, year, &start,=0A=
					stdoffset);=0A=
				endtime =3D transtime(janfirst, year, &end,=0A=
					dstoffset);=0A=
				if (starttime > endtime) {=0A=
					*atp++ =3D endtime;=0A=
					*typep++ =3D 1;	/* DST ends */=0A=
					*atp++ =3D starttime;=0A=
					*typep++ =3D 0;	/* DST begins */=0A=
				} else {=0A=
					*atp++ =3D starttime;=0A=
					*typep++ =3D 0;	/* DST begins */=0A=
					*atp++ =3D endtime;=0A=
					*typep++ =3D 1;	/* DST ends */=0A=
				}=0A=
				janfirst +=3D year_lengths[isleap(year)] *=0A=
					SECSPERDAY;=0A=
			}=0A=
		} else {=0A=
			register long	theirstdoffset;=0A=
			register long	theirdstoffset;=0A=
			register long	theiroffset;=0A=
			register int	isdst;=0A=
			register int	i;=0A=
			register int	j;=0A=
=0A=
			if (*name !=3D '\0')=0A=
				return -1;=0A=
			if (load_result !=3D 0)=0A=
				return -1;=0A=
			/*=0A=
			** Initial values of theirstdoffset and theirdstoffset.=0A=
			*/=0A=
			theirstdoffset =3D 0;=0A=
			for (i =3D 0; i < sp->timecnt; ++i) {=0A=
				j =3D sp->types[i];=0A=
				if (!sp->ttis[j].tt_isdst) {=0A=
					theirstdoffset =3D=0A=
						-sp->ttis[j].tt_gmtoff;=0A=
					break;=0A=
				}=0A=
			}=0A=
			theirdstoffset =3D 0;=0A=
			for (i =3D 0; i < sp->timecnt; ++i) {=0A=
				j =3D sp->types[i];=0A=
				if (sp->ttis[j].tt_isdst) {=0A=
					theirdstoffset =3D=0A=
						-sp->ttis[j].tt_gmtoff;=0A=
					break;=0A=
				}=0A=
			}=0A=
			/*=0A=
			** Initially we're assumed to be in standard time.=0A=
			*/=0A=
			isdst =3D FALSE;=0A=
			theiroffset =3D theirstdoffset;=0A=
			/*=0A=
			** Now juggle transition times and types=0A=
			** tracking offsets as you do.=0A=
			*/=0A=
			for (i =3D 0; i < sp->timecnt; ++i) {=0A=
				j =3D sp->types[i];=0A=
				sp->types[i] =3D sp->ttis[j].tt_isdst;=0A=
				if (sp->ttis[j].tt_ttisgmt) {=0A=
					/* No adjustment to transition time */=0A=
				} else {=0A=
					/*=0A=
					** If summer time is in effect, and the=0A=
					** transition time was not specified as=0A=
					** standard time, add the summer time=0A=
					** offset to the transition time;=0A=
					** otherwise, add the standard time=0A=
					** offset to the transition time.=0A=
					*/=0A=
					/*=0A=
					** Transitions from DST to DDST=0A=
					** will effectively disappear since=0A=
					** POSIX provides for only one DST=0A=
					** offset.=0A=
					*/=0A=
					if (isdst && !sp->ttis[j].tt_ttisstd) {=0A=
						sp->ats[i] +=3D dstoffset -=0A=
							theirdstoffset;=0A=
					} else {=0A=
						sp->ats[i] +=3D stdoffset -=0A=
							theirstdoffset;=0A=
					}=0A=
				}=0A=
				theiroffset =3D -sp->ttis[j].tt_gmtoff;=0A=
				if (sp->ttis[j].tt_isdst)=0A=
					theirdstoffset =3D theiroffset;=0A=
				else	theirstdoffset =3D theiroffset;=0A=
			}=0A=
			/*=0A=
			** Finally, fill in ttis.=0A=
			** ttisstd and ttisgmt need not be handled.=0A=
			*/=0A=
			sp->ttis[0].tt_gmtoff =3D -stdoffset;=0A=
			sp->ttis[0].tt_isdst =3D FALSE;=0A=
			sp->ttis[0].tt_abbrind =3D 0;=0A=
			sp->ttis[1].tt_gmtoff =3D -dstoffset;=0A=
			sp->ttis[1].tt_isdst =3D TRUE;=0A=
			sp->ttis[1].tt_abbrind =3D stdlen + 1;=0A=
			sp->typecnt =3D 2;=0A=
		}=0A=
	} else {=0A=
		dstlen =3D 0;=0A=
		sp->typecnt =3D 1;		/* only standard time */=0A=
		sp->timecnt =3D 0;=0A=
		sp->ttis[0].tt_gmtoff =3D -stdoffset;=0A=
		sp->ttis[0].tt_isdst =3D 0;=0A=
		sp->ttis[0].tt_abbrind =3D 0;=0A=
	}=0A=
	sp->charcnt =3D stdlen + 1;=0A=
	if (dstlen !=3D 0)=0A=
		sp->charcnt +=3D dstlen + 1;=0A=
	if ((size_t) sp->charcnt > sizeof sp->chars)=0A=
		return -1;=0A=
	cp =3D sp->chars;=0A=
	(void) strncpy(cp, stdname, stdlen);=0A=
	cp +=3D stdlen;=0A=
	*cp++ =3D '\0';=0A=
	if (dstlen !=3D 0) {=0A=
		(void) strncpy(cp, dstname, dstlen);=0A=
		*(cp + dstlen) =3D '\0';=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
static void=0A=
gmtload(struct state *sp)=0A=
{=0A=
	if (tzload(gmt, sp) !=3D 0)=0A=
		(void) tzparse(gmt, sp, TRUE);=0A=
}=0A=
=0A=
#ifndef STD_INSPIRED=0A=
/*=0A=
** A non-static declaration of tzsetwall in a system header file=0A=
** may cause a warning about this upcoming static declaration...=0A=
*/=0A=
static=0A=
#endif /* !defined STD_INSPIRED */=0A=
void=0A=
tzsetwall P((void))=0A=
{=0A=
	if (lcl_is_set < 0)=0A=
		return;=0A=
	lcl_is_set =3D -1;=0A=
=0A=
#ifdef ALL_STATE=0A=
	if (lclptr =3D=3D NULL) {=0A=
		lclptr =3D (struct state *) malloc(sizeof *lclptr);=0A=
		if (lclptr =3D=3D NULL) {=0A=
			settzname();	/* all we can do */=0A=
			return;=0A=
		}=0A=
	}=0A=
#endif /* defined ALL_STATE */=0A=
#if defined (_WIN32) || defined (__CYGWIN__)=0A=
#define is_upper(c) ((unsigned)(c) - 'A' <=3D 26)=0A=
	{=0A=
	    TIME_ZONE_INFORMATION tz;=0A=
	    char buf[BUFSIZ];=0A=
	    char *cp, *dst;=0A=
	    wchar_t *src;=0A=
	    div_t d;=0A=
	    GetTimeZoneInformation(&tz);=0A=
	    dst =3D cp =3D buf;=0A=
=09=20=20=20=20=0A=
	    for (src =3D tz.StandardName; *src; src++)=0A=
	      if (is_upper(*src)) *dst++ =3D *src;=0A=
=0A=
	    /* not 3 characters for timezone _tzname[0] ?=20=0A=
               happens for example in Win2000/NT german version=0A=
               a) tz.StandardName is a WideChar String=0A=
               b) is very long "Westeropaische Normalzeit"=0A=
               generate a TZ variable relative to GMT-x=0A=
               (if strlen of _tzname is not equal 3 , tzparse will=20=0A=
                not accept the TZ variable!)=0A=
               mkt */=0A=
            if (strlen(cp) !=3D 3)            /* mkt */=0A=
            {                               /* mkt */=0A=
               strcpy(cp, "GMT");           /* mkt */=0A=
               dst =3D cp + 3;                /* mkt */=0A=
            }                               /* mkt */=0A=
=0A=
	    if (cp =3D=3D dst)=0A=
	      {=0A=
		/* In Asian Windows, tz.StandardName may not contain=0A=
		   the timezone name. */=0A=
		strcpy(cp, wildabbr);=0A=
		cp +=3D strlen(wildabbr);=0A=
	      }=0A=
	    else=0A=
	      cp =3D dst;=0A=
=0A=
            if (=0A=
		strcpy(cp,"GMT");=0A=
		cp=3Dstrchr(cp, 0);=0A=
#endif=09=20=20=20=20=20=20=0A=
            d =3D div(tz.Bias, 60);              /* ??? mkt */=0A=
   	    if ( tz.StandardDate.wMonth !=3D 0 ) /* ??? this seems to be the Mi=
crosoft compatible algorithm  mkt */=0A=
	       d +=3D div(tz.StandardBias, 60);  /* ??? mkt */=0A=
=0A=
	    sprintf(cp, "%d", d.quot);=0A=
	    if (d.rem)=0A=
		sprintf(cp=3Dstrchr(cp, 0), ":%d", abs(d.rem));=0A=
	    if(tz.StandardDate.wMonth) {=0A=
		cp =3D strchr(cp, 0);=0A=
		dst =3D cp;=0A=
=09=0A=
		for (src =3D tz.DaylightName; *src; src++)=0A=
		  if (is_upper(*src)) *dst++ =3D *src;=0A=
=0A=
   	       /* not 3 characters for daylight timezone _tzname[1] ?=20=0A=
                  happens for example in Win2000/NT german version=0A=
                  a) tz.StandardName is a WideChar String=0A=
                  b) is very long "Westeropaische Sommerzeit"=0A=
                  generate a TZ variable relative to GMT-xDST-y=0A=
                  (if strlen of _tzname is not equal 3 , tzparse will=20=0A=
                   not accept the TZ variable!)=0A=
                  mkt */=0A=
               if (strlen(cp) !=3D 3)            /* mkt */=0A=
               {                               /* mkt */=0A=
                  strcpy(cp, "DST");           /* mkt */=0A=
                  dst =3D cp + 3;                /* mkt */=0A=
               }                               /* mkt */=0A=
=0A=
		if (cp =3D=3D dst)=0A=
		  {=0A=
		    /* In Asian Windows, tz.StandardName may not contain=0A=
		       the daylight name. */=0A=
		    strcpy(buf, wildabbr);=0A=
		    cp +=3D strlen(wildabbr);=0A=
		  }=0A=
		else=0A=
		  cp =3D dst;=0A=
=0A=
		d =3D div(tz.Bias+tz.DaylightBias, 60);=0A=
		sprintf(cp, "%d", d.quot);=0A=
		if (d.rem)=0A=
		    sprintf(cp=3Dstrchr(cp, 0), ":%d", abs(d.rem));=0A=
		cp =3D strchr(cp, 0);=0A=
		sprintf(cp=3Dstrchr(cp, 0), ",M%d.%d.%d/%d",=0A=
		    tz.DaylightDate.wMonth,=0A=
		    tz.DaylightDate.wDay,=0A=
		    tz.DaylightDate.wDayOfWeek,=0A=
		    tz.DaylightDate.wHour);=0A=
		if (tz.DaylightDate.wMinute || tz.DaylightDate.wSecond)=0A=
		    sprintf(cp=3Dstrchr(cp, 0), ":%d", tz.DaylightDate.wMinute);=0A=
		if (tz.DaylightDate.wSecond)=0A=
		    sprintf(cp=3Dstrchr(cp, 0), ":%d", tz.DaylightDate.wSecond);=0A=
		cp =3D strchr(cp, 0);=0A=
		sprintf(cp=3Dstrchr(cp, 0), ",M%d.%d.%d/%d",=0A=
		    tz.StandardDate.wMonth,=0A=
		    tz.StandardDate.wDay,=0A=
		    tz.StandardDate.wDayOfWeek,=0A=
		    tz.StandardDate.wHour);=0A=
		if (tz.StandardDate.wMinute || tz.StandardDate.wSecond)=0A=
		    sprintf(cp=3Dstrchr(cp, 0), ":%d", tz.StandardDate.wMinute);=0A=
		if (tz.StandardDate.wSecond)=0A=
		    sprintf(cp=3Dstrchr(cp, 0), ":%d", tz.StandardDate.wSecond);=0A=
	    }=0A=
	    /* printf("TZ deduced as `%s'\n", buf); */=0A=
	    if (tzparse(buf, lclptr, FALSE) =3D=3D 0) {=0A=
		settzname();=0A=
		setenv("TZ", buf, 1);=0A=
		return;=0A=
	    }=0A=
	}=0A=
#endif=0A=
	if (tzload((char *) NULL, lclptr) !=3D 0)=0A=
		gmtload(lclptr);=0A=
	settzname();=0A=
}=0A=
=0A=
extern "C" void=0A=
tzset P((void))=0A=
{=0A=
	const char *	name =3D getenv("TZ");=0A=
=0A=
	if (name =3D=3D NULL) {=0A=
		tzsetwall();=0A=
		return;=0A=
	}=0A=
=0A=
	if (lcl_is_set > 0  &&  strcmp(lcl_TZname, name) =3D=3D 0)=0A=
		return;=0A=
	lcl_is_set =3D (strlen(name) < sizeof(lcl_TZname));=0A=
	if (lcl_is_set)=0A=
		(void) strcpy(lcl_TZname, name);=0A=
=0A=
#ifdef ALL_STATE=0A=
	if (lclptr =3D=3D NULL) {=0A=
		lclptr =3D (struct state *) malloc(sizeof *lclptr);=0A=
		if (lclptr =3D=3D NULL) {=0A=
			settzname();	/* all we can do */=0A=
			return;=0A=
		}=0A=
	}=0A=
#endif /* defined ALL_STATE */=0A=
	if (*name =3D=3D '\0') {=0A=
		/*=0A=
		** User wants it fast rather than right.=0A=
		*/=0A=
		lclptr->leapcnt =3D 0;		/* so, we're off a little */=0A=
		lclptr->timecnt =3D 0;=0A=
		lclptr->ttis[0].tt_gmtoff =3D 0;=0A=
		lclptr->ttis[0].tt_abbrind =3D 0;=0A=
		(void) strcpy(lclptr->chars, gmt);=0A=
	} else if (tzload(name, lclptr) !=3D 0) {=0A=
		if (name[0] =3D=3D ':' || tzparse(name, lclptr, FALSE) !=3D 0)=0A=
			(void) gmtload(lclptr);=0A=
	}=0A=
	settzname();=0A=
}=0A=
=0A=
/*=0A=
** The easy way to behave "as if no library function calls" localtime=0A=
** is to not call it--so we drop its guts into "localsub", which can be=0A=
** freely called.  (And no, the PANS doesn't require the above behavior--=
=0A=
** but it *is* desirable.)=0A=
**=0A=
** The unused offset argument is for the benefit of mktime variants.=0A=
*/=0A=
=0A=
/*ARGSUSED*/=0A=
static void=0A=
localsub (const time_t * const	timep,=0A=
	  const long offset,=0A=
	  struct tm * const tmp)=0A=
{=0A=
	register struct state *		sp;=0A=
	register const struct ttinfo *	ttisp;=0A=
	register int			i;=0A=
	const time_t			t =3D *timep;=0A=
=0A=
	sp =3D lclptr;=0A=
#ifdef ALL_STATE=0A=
	if (sp =3D=3D NULL) {=0A=
		gmtsub(timep, offset, tmp);=0A=
		return;=0A=
	}=0A=
#endif /* defined ALL_STATE */=0A=
	if (sp->timecnt =3D=3D 0 || t < sp->ats[0]) {=0A=
		i =3D 0;=0A=
		while (sp->ttis[i].tt_isdst)=0A=
			if (++i >=3D sp->typecnt) {=0A=
				i =3D 0;=0A=
				break;=0A=
			}=0A=
	} else {=0A=
		for (i =3D 1; i < sp->timecnt; ++i)=0A=
			if (t < sp->ats[i])=0A=
				break;=0A=
		i =3D sp->types[i - 1];=0A=
	}=0A=
	ttisp =3D &sp->ttis[i];=0A=
	/*=0A=
	** To get (wrong) behavior that's compatible with System V Release 2.0=0A=
	** you'd replace the statement below with=0A=
	**	t +=3D ttisp->tt_gmtoff;=0A=
	**	timesub(&t, 0L, sp, tmp);=0A=
	*/=0A=
	timesub(&t, ttisp->tt_gmtoff, sp, tmp);=0A=
	tmp->tm_isdst =3D ttisp->tt_isdst;=0A=
	tzname[tmp->tm_isdst] =3D &sp->chars[ttisp->tt_abbrind];=0A=
#ifdef TM_ZONE=0A=
	tmp->TM_ZONE =3D &sp->chars[ttisp->tt_abbrind];=0A=
#endif /* defined TM_ZONE */=0A=
}=0A=
=0A=
extern "C" struct tm *=0A=
localtime(const time_t *timep)=0A=
{=0A=
	tzset();=0A=
	localsub(timep, 0L, &tm);=0A=
	return &tm;=0A=
}=0A=
=0A=
/*=0A=
 * Re-entrant version of localtime=0A=
 */=0A=
extern "C" struct tm *=0A=
localtime_r(const time_t *timep, struct tm *tm)=0A=
{=0A=
	localsub(timep, 0L, tm);=0A=
	return tm;=0A=
}=0A=
=0A=
/*=0A=
** gmtsub is to gmtime as localsub is to localtime.=0A=
*/=0A=
=0A=
static void=0A=
gmtsub(const time_t *timep, const long offset, struct tm *tmp)=0A=
{=0A=
	if (!gmt_is_set) {=0A=
		gmt_is_set =3D TRUE;=0A=
#ifdef ALL_STATE=0A=
		gmtptr =3D (struct state *) malloc(sizeof *gmtptr);=0A=
		if (gmtptr !=3D NULL)=0A=
#endif /* defined ALL_STATE */=0A=
			gmtload(gmtptr);=0A=
	}=0A=
	timesub(timep, offset, gmtptr, tmp);=0A=
#ifdef TM_ZONE=0A=
	/*=0A=
	** Could get fancy here and deliver something such as=0A=
	** "UTC+xxxx" or "UTC-xxxx" if offset is non-zero,=0A=
	** but this is no time for a treasure hunt.=0A=
	*/=0A=
	if (offset !=3D 0)=0A=
		tmp->TM_ZONE =3D wildabbr;=0A=
	else {=0A=
#ifdef ALL_STATE=0A=
		if (gmtptr =3D=3D NULL)=0A=
			tmp->TM_ZONE =3D gmt;=0A=
		else	tmp->TM_ZONE =3D gmtptr->chars;=0A=
#endif /* defined ALL_STATE */=0A=
#ifndef ALL_STATE=0A=
		tmp->TM_ZONE =3D gmtptr->chars;=0A=
#endif /* State Farm */=0A=
	}=0A=
#endif /* defined TM_ZONE */=0A=
}=0A=
=0A=
extern "C" struct tm *=0A=
gmtime(const time_t *timep)=0A=
{=0A=
	gmtsub(timep, 0L, &tm);=0A=
	return &tm;=0A=
}=0A=
=0A=
/*=0A=
 * Re-entrant version of gmtime=0A=
 */=0A=
extern "C" struct tm *=0A=
gmtime_r(const time_t *timep, struct tm *tm)=0A=
{=0A=
	gmtsub(timep, 0L, tm);=0A=
	return tm;=0A=
}=0A=
=0A=
#ifdef STD_INSPIRED=0A=
=0A=
extern "C" struct tm *=0A=
offtime(const time_t *timep, const long offset)=0A=
{=0A=
	gmtsub(timep, offset, &tm);=0A=
	return &tm;=0A=
}=0A=
=0A=
#endif /* defined STD_INSPIRED */=0A=
=0A=
static void=0A=
timesub(const time_t *timep, const long offset, const struct state *sp,=0A=
	struct tm *tmp)=0A=
{=0A=
	register const struct lsinfo *	lp;=0A=
	register long			days;=0A=
	register long			rem;=0A=
	register int			y;=0A=
	register int			yleap;=0A=
	register const int *		ip;=0A=
	register long			corr;=0A=
	register int			hit;=0A=
	register int			i;=0A=
=0A=
	corr =3D 0;=0A=
	hit =3D 0;=0A=
#ifdef ALL_STATE=0A=
	i =3D (sp =3D=3D NULL) ? 0 : sp->leapcnt;=0A=
#endif /* defined ALL_STATE */=0A=
#ifndef ALL_STATE=0A=
	i =3D sp->leapcnt;=0A=
#endif /* State Farm */=0A=
	while (--i >=3D 0) {=0A=
		lp =3D &sp->lsis[i];=0A=
		if (*timep >=3D lp->ls_trans) {=0A=
			if (*timep =3D=3D lp->ls_trans) {=0A=
				hit =3D ((i =3D=3D 0 && lp->ls_corr > 0) ||=0A=
					lp->ls_corr > sp->lsis[i - 1].ls_corr);=0A=
				if (hit)=0A=
					while (i > 0 &&=0A=
						sp->lsis[i].ls_trans =3D=3D=0A=
						sp->lsis[i - 1].ls_trans + 1 &&=0A=
						sp->lsis[i].ls_corr =3D=3D=0A=
						sp->lsis[i - 1].ls_corr + 1) {=0A=
							++hit;=0A=
							--i;=0A=
					}=0A=
			}=0A=
			corr =3D lp->ls_corr;=0A=
			break;=0A=
		}=0A=
	}=0A=
	days =3D *timep / SECSPERDAY;=0A=
	rem =3D *timep % SECSPERDAY;=0A=
#ifdef mc68k=0A=
	if (*timep =3D=3D 0x80000000) {=0A=
		/*=0A=
		** A 3B1 muffs the division on the most negative number.=0A=
		*/=0A=
		days =3D -24855;=0A=
		rem =3D -11648;=0A=
	}=0A=
#endif /* defined mc68k */=0A=
	rem +=3D (offset - corr);=0A=
	while (rem < 0) {=0A=
		rem +=3D SECSPERDAY;=0A=
		--days;=0A=
	}=0A=
	while (rem >=3D SECSPERDAY) {=0A=
		rem -=3D SECSPERDAY;=0A=
		++days;=0A=
	}=0A=
	tmp->tm_hour =3D (int) (rem / SECSPERHOUR);=0A=
	rem =3D rem % SECSPERHOUR;=0A=
	tmp->tm_min =3D (int) (rem / SECSPERMIN);=0A=
	/*=0A=
	** A positive leap second requires a special=0A=
	** representation.  This uses "... ??:59:60" et seq.=0A=
	*/=0A=
	tmp->tm_sec =3D (int) (rem % SECSPERMIN) + hit;=0A=
	tmp->tm_wday =3D (int) ((EPOCH_WDAY + days) % DAYSPERWEEK);=0A=
	if (tmp->tm_wday < 0)=0A=
		tmp->tm_wday +=3D DAYSPERWEEK;=0A=
	y =3D EPOCH_YEAR;=0A=
#define LEAPS_THRU_END_OF(y)	((y) / 4 - (y) / 100 + (y) / 400)=0A=
	while (days < 0 || days >=3D (long) year_lengths[yleap =3D isleap(y)]) {=
=0A=
		register int	newy;=0A=
=0A=
		newy =3D y + days / DAYSPERNYEAR;=0A=
		if (days < 0)=0A=
			--newy;=0A=
		days -=3D (newy - y) * DAYSPERNYEAR +=0A=
			LEAPS_THRU_END_OF(newy - 1) -=0A=
			LEAPS_THRU_END_OF(y - 1);=0A=
		y =3D newy;=0A=
	}=0A=
	tmp->tm_year =3D y - TM_YEAR_BASE;=0A=
	tmp->tm_yday =3D (int) days;=0A=
	ip =3D mon_lengths[yleap];=0A=
	for (tmp->tm_mon =3D 0; days >=3D (long) ip[tmp->tm_mon]; ++(tmp->tm_mon))=
=0A=
		days =3D days - (long) ip[tmp->tm_mon];=0A=
	tmp->tm_mday =3D (int) (days + 1);=0A=
	tmp->tm_isdst =3D 0;=0A=
#ifdef TM_GMTOFF=0A=
	tmp->TM_GMTOFF =3D offset;=0A=
#endif /* defined TM_GMTOFF */=0A=
}=0A=
=0A=
extern "C" char *=0A=
ctime(const time_t *timep)=0A=
{=0A=
/*=0A=
** Section 4.12.3.2 of X3.159-1989 requires that=0A=
**	The ctime function converts the calendar time pointed to by timer=0A=
**	to local time in the form of a string.  It is equivalent to=0A=
**		asctime(localtime(timer))=0A=
*/=0A=
	return asctime(localtime(timep));=0A=
}=0A=
=0A=
extern "C" char *=0A=
ctime_r(const time_t *timep, char *buf)=0A=
{=0A=
	struct tm	tm;=0A=
=0A=
	return asctime_r(localtime_r(timep, &tm), buf);=0A=
}=0A=
=0A=
/*=0A=
** Adapted from code provided by Robert Elz, who writes:=0A=
**	The "best" way to do mktime I think is based on an idea of Bob=0A=
**	Kridle's (so its said...) from a long time ago.=0A=
**	[kridle@xinet.com as of 1996-01-16.]=0A=
**	It does a binary search of the time_t space.  Since time_t's are=0A=
**	just 32 bits, its a max of 32 iterations (even at 64 bits it=0A=
**	would still be very reasonable).=0A=
*/=0A=
=0A=
#ifndef WRONG=0A=
#define WRONG	(-1)=0A=
#endif /* !defined WRONG */=0A=
=0A=
/*=0A=
** Simplified normalize logic courtesy Paul Eggert (eggert@twinsun.com).=0A=
*/=0A=
=0A=
static int=0A=
increment_overflow(int *number, int delta)=0A=
{=0A=
	int	number0;=0A=
=0A=
	number0 =3D *number;=0A=
	*number +=3D delta;=0A=
	return (*number < number0) !=3D (delta < 0);=0A=
}=0A=
=0A=
static int=0A=
normalize_overflow(int *tensptr, int *unitsptr, const int base)=0A=
{=0A=
	register int	tensdelta;=0A=
=0A=
	tensdelta =3D (*unitsptr >=3D 0) ?=0A=
		(*unitsptr / base) :=0A=
		(-1 - (-1 - *unitsptr) / base);=0A=
	*unitsptr -=3D tensdelta * base;=0A=
	return increment_overflow(tensptr, tensdelta);=0A=
}=0A=
=0A=
static int=0A=
tmcomp(register const struct tm *atmp, register const struct tm *btmp)=0A=
{=0A=
	register int	result;=0A=
=0A=
	if ((result =3D (atmp->tm_year - btmp->tm_year)) =3D=3D 0 &&=0A=
		(result =3D (atmp->tm_mon - btmp->tm_mon)) =3D=3D 0 &&=0A=
		(result =3D (atmp->tm_mday - btmp->tm_mday)) =3D=3D 0 &&=0A=
		(result =3D (atmp->tm_hour - btmp->tm_hour)) =3D=3D 0 &&=0A=
		(result =3D (atmp->tm_min - btmp->tm_min)) =3D=3D 0)=0A=
			result =3D atmp->tm_sec - btmp->tm_sec;=0A=
	return result;=0A=
}=0A=
=0A=
static time_t=0A=
time2sub(struct tm *tmp, void (*funcp) P((const time_t*, long, struct tm*))=
,=0A=
	 const long offset, int *okayp, const int do_norm_secs)=0A=
{=0A=
	register const struct state *	sp;=0A=
	register int			dir;=0A=
	register int			bits;=0A=
	register int			i, j ;=0A=
	register int			saved_seconds;=0A=
	time_t				newt;=0A=
	time_t				t;=0A=
	struct tm			yourtm, mytm;=0A=
=0A=
	*okayp =3D FALSE;=0A=
	yourtm =3D *tmp;=0A=
	if (do_norm_secs) {=0A=
		if (normalize_overflow(&yourtm.tm_min, &yourtm.tm_sec,=0A=
			SECSPERMIN))=0A=
				return WRONG;=0A=
	}=0A=
	if (normalize_overflow(&yourtm.tm_hour, &yourtm.tm_min, MINSPERHOUR))=0A=
		return WRONG;=0A=
	if (normalize_overflow(&yourtm.tm_mday, &yourtm.tm_hour, HOURSPERDAY))=0A=
		return WRONG;=0A=
	if (normalize_overflow(&yourtm.tm_year, &yourtm.tm_mon, MONSPERYEAR))=0A=
		return WRONG;=0A=
	/*=0A=
	** Turn yourtm.tm_year into an actual year number for now.=0A=
	** It is converted back to an offset from TM_YEAR_BASE later.=0A=
	*/=0A=
	if (increment_overflow(&yourtm.tm_year, TM_YEAR_BASE))=0A=
		return WRONG;=0A=
	while (yourtm.tm_mday <=3D 0) {=0A=
		if (increment_overflow(&yourtm.tm_year, -1))=0A=
			return WRONG;=0A=
		i =3D yourtm.tm_year + (1 < yourtm.tm_mon);=0A=
		yourtm.tm_mday +=3D year_lengths[isleap(i)];=0A=
	}=0A=
	while (yourtm.tm_mday > DAYSPERLYEAR) {=0A=
		i =3D yourtm.tm_year + (1 < yourtm.tm_mon);=0A=
		yourtm.tm_mday -=3D year_lengths[isleap(i)];=0A=
		if (increment_overflow(&yourtm.tm_year, 1))=0A=
			return WRONG;=0A=
	}=0A=
	for ( ; ; ) {=0A=
		i =3D mon_lengths[isleap(yourtm.tm_year)][yourtm.tm_mon];=0A=
		if (yourtm.tm_mday <=3D i)=0A=
			break;=0A=
		yourtm.tm_mday -=3D i;=0A=
		if (++yourtm.tm_mon >=3D MONSPERYEAR) {=0A=
			yourtm.tm_mon =3D 0;=0A=
			if (increment_overflow(&yourtm.tm_year, 1))=0A=
				return WRONG;=0A=
		}=0A=
	}=0A=
	if (increment_overflow(&yourtm.tm_year, -TM_YEAR_BASE))=0A=
		return WRONG;=0A=
	if (yourtm.tm_year + TM_YEAR_BASE < EPOCH_YEAR) {=0A=
		/*=0A=
		** We can't set tm_sec to 0, because that might push the=0A=
		** time below the minimum representable time.=0A=
		** Set tm_sec to 59 instead.=0A=
		** This assumes that the minimum representable time is=0A=
		** not in the same minute that a leap second was deleted from,=0A=
		** which is a safer assumption than using 58 would be.=0A=
		*/=0A=
		if (increment_overflow(&yourtm.tm_sec, 1 - SECSPERMIN))=0A=
			return WRONG;=0A=
		saved_seconds =3D yourtm.tm_sec;=0A=
		yourtm.tm_sec =3D SECSPERMIN - 1;=0A=
	} else {=0A=
		saved_seconds =3D yourtm.tm_sec;=0A=
		yourtm.tm_sec =3D 0;=0A=
	}=0A=
	/*=0A=
	** Divide the search space in half=0A=
	** (this works whether time_t is signed or unsigned).=0A=
	*/=0A=
	bits =3D TYPE_BIT(time_t) - 1;=0A=
	/*=0A=
	** If time_t is signed, then 0 is just above the median,=0A=
	** assuming two's complement arithmetic.=0A=
	** If time_t is unsigned, then (1 << bits) is just above the median.=0A=
	*/=0A=
	t =3D TYPE_SIGNED(time_t) ? 0 : (((time_t) 1) << bits);=0A=
	for ( ; ; ) {=0A=
		(*funcp)(&t, offset, &mytm);=0A=
		dir =3D tmcomp(&mytm, &yourtm);=0A=
		if (dir !=3D 0) {=0A=
			if (bits-- < 0)=0A=
				return WRONG;=0A=
			if (bits < 0)=0A=
				--t; /* may be needed if new t is minimal */=0A=
			else if (dir > 0)=0A=
				t -=3D ((time_t) 1) << bits;=0A=
			else	t +=3D ((time_t) 1) << bits;=0A=
			continue;=0A=
		}=0A=
		if (yourtm.tm_isdst < 0 || mytm.tm_isdst =3D=3D yourtm.tm_isdst)=0A=
			break;=0A=
		/*=0A=
		** Right time, wrong type.=0A=
		** Hunt for right time, right type.=0A=
		** It's okay to guess wrong since the guess=0A=
		** gets checked.=0A=
		*/=0A=
		/*=0A=
		** The (void *) casts are the benefit of SunOS 3.3 on Sun 2's.=0A=
		*/=0A=
		sp =3D (const struct state *)=0A=
			(((void *) funcp =3D=3D (void *) localsub) ?=0A=
			lclptr : gmtptr);=0A=
#ifdef ALL_STATE=0A=
		if (sp =3D=3D NULL)=0A=
			return WRONG;=0A=
#endif /* defined ALL_STATE */=0A=
		for (i =3D sp->typecnt - 1; i >=3D 0; --i) {=0A=
			if (sp->ttis[i].tt_isdst !=3D yourtm.tm_isdst)=0A=
				continue;=0A=
			for (j =3D sp->typecnt - 1; j >=3D 0; --j) {=0A=
				if (sp->ttis[j].tt_isdst =3D=3D yourtm.tm_isdst)=0A=
					continue;=0A=
				newt =3D t + sp->ttis[j].tt_gmtoff -=0A=
					sp->ttis[i].tt_gmtoff;=0A=
				(*funcp)(&newt, offset, &mytm);=0A=
				if (tmcomp(&mytm, &yourtm) !=3D 0)=0A=
					continue;=0A=
				if (mytm.tm_isdst !=3D yourtm.tm_isdst)=0A=
					continue;=0A=
				/*=0A=
				** We have a match.=0A=
				*/=0A=
				t =3D newt;=0A=
				goto label;=0A=
			}=0A=
		}=0A=
		return WRONG;=0A=
	}=0A=
label:=0A=
	newt =3D t + saved_seconds;=0A=
	if ((newt < t) !=3D (saved_seconds < 0))=0A=
		return WRONG;=0A=
	t =3D newt;=0A=
	(*funcp)(&t, offset, tmp);=0A=
	*okayp =3D TRUE;=0A=
	return t;=0A=
}=0A=
=0A=
static time_t=0A=
time2(struct tm *tmp, void (*funcp) P((const time_t*, long, struct tm*)),=
=0A=
      const long offset, int *okayp)=0A=
{=0A=
	time_t	t;=0A=
=0A=
	/*=0A=
	** First try without normalization of seconds=0A=
	** (in case tm_sec contains a value associated with a leap second).=0A=
	** If that fails, try with normalization of seconds.=0A=
	*/=0A=
	t =3D time2sub(tmp, funcp, offset, okayp, FALSE);=0A=
	return *okayp ? t : time2sub(tmp, funcp, offset, okayp, TRUE);=0A=
}=0A=
=0A=
static time_t=0A=
time1(struct tm *tmp, void (*funcp) P((const time_t *, long, struct tm *)),=
=0A=
      const long offset)=0A=
{=0A=
	register time_t			t;=0A=
	register const struct state *	sp;=0A=
	register int			samei, otheri;=0A=
	int				okay;=0A=
=0A=
	if (tmp->tm_isdst > 1)=0A=
		tmp->tm_isdst =3D 1;=0A=
	t =3D time2(tmp, funcp, offset, &okay);=0A=
#ifdef PCTS=0A=
	/*=0A=
	** PCTS code courtesy Grant Sullivan (grant@osf.org).=0A=
	*/=0A=
	if (okay)=0A=
		return t;=0A=
	if (tmp->tm_isdst < 0)=0A=
		tmp->tm_isdst =3D 0;	/* reset to std and try again */=0A=
#endif /* defined PCTS */=0A=
#ifndef PCTS=0A=
	if (okay || tmp->tm_isdst < 0)=0A=
		return t;=0A=
#endif /* !defined PCTS */=0A=
	/*=0A=
	** We're supposed to assume that somebody took a time of one type=0A=
	** and did some math on it that yielded a "struct tm" that's bad.=0A=
	** We try to divine the type they started from and adjust to the=0A=
	** type they need.=0A=
	*/=0A=
	/*=0A=
	** The (void *) casts are the benefit of SunOS 3.3 on Sun 2's.=0A=
	*/=0A=
	sp =3D (const struct state *) (((void *) funcp =3D=3D (void *) localsub) ?=
=0A=
		lclptr : gmtptr);=0A=
#ifdef ALL_STATE=0A=
	if (sp =3D=3D NULL)=0A=
		return WRONG;=0A=
#endif /* defined ALL_STATE */=0A=
	for (samei =3D sp->typecnt - 1; samei >=3D 0; --samei) {=0A=
		if (sp->ttis[samei].tt_isdst !=3D tmp->tm_isdst)=0A=
			continue;=0A=
		for (otheri =3D sp->typecnt - 1; otheri >=3D 0; --otheri) {=0A=
			if (sp->ttis[otheri].tt_isdst =3D=3D tmp->tm_isdst)=0A=
				continue;=0A=
			tmp->tm_sec +=3D sp->ttis[otheri].tt_gmtoff -=0A=
					sp->ttis[samei].tt_gmtoff;=0A=
			tmp->tm_isdst =3D !tmp->tm_isdst;=0A=
			t =3D time2(tmp, funcp, offset, &okay);=0A=
			if (okay)=0A=
				return t;=0A=
			tmp->tm_sec -=3D sp->ttis[otheri].tt_gmtoff -=0A=
					sp->ttis[samei].tt_gmtoff;=0A=
			tmp->tm_isdst =3D !tmp->tm_isdst;=0A=
		}=0A=
	}=0A=
	return WRONG;=0A=
}=0A=
=0A=
extern "C" time_t=0A=
mktime(struct tm *tmp)=0A=
{=0A=
	tzset();=0A=
	return time1(tmp, localsub, 0L);=0A=
}=0A=
=0A=
#ifdef STD_INSPIRED=0A=
=0A=
extern "C" time_t=0A=
timelocal(struct tm *tmp)=0A=
{=0A=
	tmp->tm_isdst =3D -1;	/* in case it wasn't initialized */=0A=
	return mktime(tmp);=0A=
}=0A=
=0A=
extern "C" time_t=0A=
timegm(struct tm *tmp)=0A=
{=0A=
	tmp->tm_isdst =3D 0;=0A=
	return time1(tmp, gmtsub, 0L);=0A=
}=0A=
=0A=
extern "C" time_t=0A=
timeoff(struct tm *tmp, const long offset)=0A=
{=0A=
	tmp->tm_isdst =3D 0;=0A=
	return time1(tmp, gmtsub, offset);=0A=
}=0A=
=0A=
#endif /* defined STD_INSPIRED */=0A=
=0A=
#ifdef CMUCS=0A=
=0A=
/*=0A=
** The following is supplied for compatibility with=0A=
** previous versions of the CMUCS runtime library.=0A=
*/=0A=
=0A=
extern "C" long=0A=
gtime(struct tm *tmp)=0A=
{=0A=
	const time_t	t =3D mktime(tmp);=0A=
=0A=
	if (t =3D=3D WRONG)=0A=
		return -1;=0A=
	return t;=0A=
}=0A=
=0A=
#endif /* defined CMUCS */=0A=
=0A=
/*=0A=
** XXX--is the below the right way to conditionalize??=0A=
*/=0A=
=0A=
#ifdef STD_INSPIRED=0A=
=0A=
/*=0A=
** IEEE Std 1003.1-1988 (POSIX) legislates that 536457599=0A=
** shall correspond to "Wed Dec 31 23:59:59 UTC 1986", which=0A=
** is not the case if we are accounting for leap seconds.=0A=
** So, we provide the following conversion routines for use=0A=
** when exchanging timestamps with POSIX conforming systems.=0A=
*/=0A=
=0A=
static long=0A=
leapcorr(time_t *timep)=0A=
{=0A=
	register struct state *		sp;=0A=
	register struct lsinfo *	lp;=0A=
	register int			i;=0A=
=0A=
	sp =3D lclptr;=0A=
	i =3D sp->leapcnt;=0A=
	while (--i >=3D 0) {=0A=
		lp =3D &sp->lsis[i];=0A=
		if (*timep >=3D lp->ls_trans)=0A=
			return lp->ls_corr;=0A=
	}=0A=
	return 0;=0A=
}=0A=
=0A=
extern "C" time_t=0A=
time2posix(time_t t)=0A=
{=0A=
	tzset();=0A=
	return t - leapcorr(&t);=0A=
}=0A=
=0A=
extern "C" time_t=0A=
posix2time(time_t t)=0A=
{=0A=
	time_t	x;=0A=
	time_t	y;=0A=
=0A=
	tzset();=0A=
	/*=0A=
	** For a positive leap second hit, the result=0A=
	** is not unique.  For a negative leap second=0A=
	** hit, the corresponding time doesn't exist,=0A=
	** so we return an adjacent second.=0A=
	*/=0A=
	x =3D t + leapcorr(&t);=0A=
	y =3D x - leapcorr(&x);=0A=
	if (y < t) {=0A=
		do {=0A=
			x++;=0A=
			y =3D x - leapcorr(&x);=0A=
		} while (y < t);=0A=
		if (t !=3D y)=0A=
			return x - 1;=0A=
	} else if (y > t) {=0A=
		do {=0A=
			--x;=0A=
			y =3D x - leapcorr(&x);=0A=
		} while (y > t);=0A=
		if (t !=3D y)=0A=
			return x + 1;=0A=
	}=0A=
	return x;=0A=
}=0A=
=0A=
#endif /* defined STD_INSPIRED */=0A=

------_=_NextPart_000_01C1BFB5.18148BB0--
