Return-Path: <cygwin-patches-return-3514-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11821 invoked by alias); 5 Feb 2003 21:27:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11812 invoked from network); 5 Feb 2003 21:27:16 -0000
Message-Id: <3.0.5.32.20030205162645.007fd100@h00207811519c.ne.client2.attbi.com>
X-Sender: pierre@h00207811519c.ne.client2.attbi.com
Date: Wed, 05 Feb 2003 21:27:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: ntsec odds and ends (cygcheck augmentation?)
In-Reply-To: <20030205183009.GI15400@redhat.com>
References: <3.0.5.32.20030205123403.007e8a80@h00207811519c.ne.client2.attbi.com>
 <20030205164834.GE15400@redhat.com>
 <3.0.5.32.20030205114159.00800620@mail.attbi.com>
 <20030205164834.GE15400@redhat.com>
 <3.0.5.32.20030205123403.007e8a80@h00207811519c.ne.client2.attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=====================_1044498405==_"
X-SW-Source: 2003-q1/txt/msg00163.txt.bz2

--=====================_1044498405==_
Content-Type: text/plain; charset="us-ascii"
Content-length: 1047

At 01:30 PM 2/5/2003 -0500, Christopher Faylor wrote:
>I think that initial feedback is a *great* idea but if cygcheck can
>provide some kind of information that would allow diagnosing a
>problem, that would be useful, too.
>
>Maybe it could just dump selected fields from /etc/passwd and
>/etc/group.

I found the check program I had written and attach it FYI, 
have fun testing weird cases.

Simple things, such as dumping /etc/passwd fields, can easily be done 
from a script, perhaps providing immediate feedback.

I am off till late Sunday. It would be nice if a consensus could emerge 
on how to best solve the recurring problems faced by new users. 
I am convinced that a new setup.exe, with a new passwd-grp.sh and no 
passwd-grp.bat, would solve 90% of the problems.

Meanwhile Cygwin has always made progress from experimentations and one
could give a shot at what I tried in the latest patch.

I am still interested to hear if "mkpasswd -l -c" provides a correct 
entry (the last line) for domain users, in all circumstances. 

Pierre


--=====================_1044498405==_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="cygntsec.c"
Content-length: 5841

#include <stdio.h>
#include <string.h>
#include <limits.h>
#include <unistd.h>
#include <pwd.h>
#include <grp.h>
#include <windows.h>

#define DEFAULT_UID_NT 400
#define DEFAULT_GID 401

char usidstring [100], gsidstring [100];

void sidstring (char *nsidstr, PSID psid)
{
  char *t =3D nsidstr;
  DWORD i;
  int s;

  strcpy (t, "S-1-");
  t +=3D sizeof ("S-1-") - 1;
  s =3D sprintf (t, "%u", GetSidIdentifierAuthority (psid)->Value[5]);
  for (i =3D 0; i < *GetSidSubAuthorityCount (psid); ++i)
    s =3D sprintf (t +=3D s, "-%lu", *GetSidSubAuthority (psid, i));
}

void getsids ()
{
  HANDLE ptok;
  struct {
    PSID psid;
    char buffer[40];
  } sid;
  DWORD siz;

  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &ptok))
    fprintf(stderr, "I cannot read my process access token.\n"
	    "Windows error %ld.\n", GetLastError ());
  else
    {
      if (!GetTokenInformation (ptok, TokenUser, &sid, sizeof sid, &siz))
	fprintf(stderr, "I cannot get my own user SID.\n"
		"Windows error %ld.\n", GetLastError ());
      else
	sidstring (usidstring, sid.psid);
      if (!GetTokenInformation (ptok, TokenPrimaryGroup, &sid, sizeof sid, =
&siz))
	fprintf(stderr, "I cannot get my own group SID.\n"
		"Windows error %ld.\n", GetLastError ());
      else
	sidstring (gsidstring, sid.psid);
      CloseHandle (ptok);
    }
  if (!*usidstring || !*gsidstring)
    exit (1);
}

int main()
{
  gid_t grouplist[NGROUPS_MAX];
  int n;
  struct passwd * pw =3D NULL;
  struct group * gr =3D NULL;
  char * ptr =3D NULL;
  int isnt;

  /* Verify /etc/passwd */
  if ((isnt =3D !(GetVersion () & 0x80000000)))
    {
      getsids ();
      if (getuid () =3D=3D DEFAULT_UID_NT)
	fprintf(stdout, "My uid is %d. This value is a reserved default.\n"
		"  It is used when /etc/passwd does not contain my Windows name %s\n"
		"  nor my user SID %s.\n",
		getuid (), getlogin (), usidstring);
      else if (getpwuid (DEFAULT_UID_NT))
	fprintf(stdout, "uid %d is a reserved default.\n"
		"  It should not appear in /etc/passwd.\n",
		DEFAULT_UID_NT);
    }
  else if (getgid () =3D=3D DEFAULT_GID)
    fprintf(stdout, "My gid is %d. This value is a reserved default.\n"
	    "  It is used when /etc/passwd does not contain my name %s\n"
	    "  nor a default entry with uid 500.\n",
	    getgid (), getlogin ());

  for (n =3D 0; n < 2; n++)
    {
      char msg [100];
      if (n =3D=3D 0)
        {
	  sprintf (msg, "uid %d", getuid ());
	  pw =3D getpwuid (getuid ());
	}
      else
        {
	  sprintf (msg, "name %s", getlogin ());
	  pw =3D getpwnam (getlogin ());
	}
      if (!pw)
	fprintf(stdout, "My %s does not appear in /etc/passwd.\n", msg);
      else
        {
	  if (isnt)
	    {
	      if (!(ptr =3D strrchr (pw->pw_gecos, ',')) || strncmp (++ptr, "S-1-"=
, 4))
		fprintf(stdout, "A passwd entry for my %s does not contain a SID.\n",
			msg);
	      else if (strcmp (ptr, usidstring))
		fprintf(stdout, "A passwd entry for my %s does not contain my SID %s.\n",
			msg, usidstring);
	    }
	  if (strcasecmp (pw->pw_name, getlogin ()))
	    fprintf(stdout, "A passwd entry for my %s contains name %s instead of =
my name %s.\n"
		    "  This is legitimate but unusual.\n",
		    msg, pw->pw_name, getlogin ());
	  if (pw->pw_uid !=3D getuid ())
	    {
	      fprintf(stdout, "A passwd entry for my %s contains uid %d instead of=
 my uid %d.\n",
		      msg, pw->pw_uid, getuid ());
	      if (sizeof (uid_t) =3D=3D 2 && pw->pw_uid >=3D USHRT_MAX)
		fprintf(stdout, "  Currently uid's are short unsigned integers.\n");
	    }
	  if (pw->pw_gid !=3D getgid ())
	    {
	      fprintf(stdout, "A passwd entry for my %s contains gid %d instead of=
 my gid %d.\n",
		      msg, pw->pw_gid, getgid ());
	      if (sizeof (gid_t) =3D=3D 2 && pw->pw_gid >=3D USHRT_MAX)
		fprintf(stdout, "  Currently gid's are short unsigned integers.\n");
	    }
	}
    }

  /* Verify /etc/group */
  if (((isnt && getuid () !=3D DEFAULT_UID_NT)
       || (!isnt && getgid () !=3D DEFAULT_GID))
      && getgrgid (DEFAULT_GID))
    fprintf(stdout, "gid %d is a reserved default.\n"
	    "  It should not appear in /etc/group.\n",
	    DEFAULT_GID);
  /* Use getgrent to detect possible augmented entry at end */
  setgrent ();
  while ((gr =3D getgrent ()))
    if (gr->gr_gid =3D=3D getgid ())
      break;
  if (gr =3D=3D NULL)
    fprintf(stdout, "My gid %d does not appear in /etc/group.\n",
	    getgid ());
  else
    {
      if (isnt)
	{
	  if (strncmp (gr->gr_passwd, "S-1-", 4))
	    fprintf(stdout, "A group entry for my gid %d does not contain a SID.\n=
",
		    getgid ());
	  else if (strcmp (gr->gr_passwd, gsidstring))
	    fprintf(stdout, "A group entry for my gid %d contains SID %s\n"
		    "  instead of my group SID %s.\n",
		    getgid (), gr->gr_passwd, gsidstring);
	  if ((ptr =3D getenv ("CYGWIN")) && strstr (ptr, "nontsec"))
	    fprintf(stdout, "ntsec is turned off. Groups cannot be verified.\n");
	  else if (!(n =3D getgroups (NGROUPS_MAX, grouplist)))
	    perror ("getgroups");
	  else
	    {
	      while (--n >=3D 0 && grouplist[n] !=3D getgid ())
	      if (n < 0)
		fprintf(stdout, "My gid %d is not one of my Windows groups.\n",
			getgid ());
	    }
	}
      /* Check for possible augmented entry at end */
      if (getgid () !=3D DEFAULT_GID
	  && ((isnt && !strcmp (gr->gr_passwd, gsidstring))
	   || (!isnt && !strcmp (gr->gr_name, "unknown") && !gr->gr_passwd[0]))
	  && gr->gr_mem[0] && !gr->gr_mem[1] && !strcmp (gr->gr_mem[0], getlogin (=
))
	  && getgrent () =3D=3D NULL)
	{
	  if (!strcmp (gr->gr_name, "unknown"))
	    fprintf(stdout, "My group name is \"%s\".\n"
		    "  This suggests that my gid %d does not appear in /etc/group.\n",
		    gr->gr_name, getgid ());
	  else if (isnt)
	    fprintf(stdout, "Verify that my gid %d appears in /etc/group.\n",
		    getgid ());
	}
    }
  exit (0);
}

--=====================_1044498405==_--
