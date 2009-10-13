Return-Path: <cygwin-patches-return-6767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1411 invoked by alias); 13 Oct 2009 22:22:28 -0000
Received: (qmail 1390 invoked by uid 22791); 13 Oct 2009 22:22:26 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_JMF_BR
X-Spam-Check-By: sourceware.org
Received: from mailout11.t-online.de (HELO mailout11.t-online.de) (194.25.134.85)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 13 Oct 2009 22:22:22 +0000
Received: from fwd07.aul.t-online.de  	by mailout11.t-online.de with smtp  	id 1Mxo1T-0001Cx-01; Tue, 13 Oct 2009 22:31:07 +0200
Received: from [10.3.2.2] (b7LhPsZf8humsY9RwFpI5yniUSiXmrFAvUtoZo9gL95kRWHST8SjIZ6ajLJlETdQwb@[217.235.253.180]) by fwd07.aul.t-online.de 	with esmtp id 1Mxo1S-13Zt8y0; Tue, 13 Oct 2009 22:31:06 +0200
Message-ID: <4AD4E38A.2050301@t-online.de>
Date: Tue, 13 Oct 2009 22:22:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090825 SeaMonkey/1.1.18
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Allow to disable root privileges with CYGWIN=noroot
References: <4A9AD529.3060107@t-online.de> <20090901183209.GA14650@calimero.vinschen.de> <20091004123006.GF4563@calimero.vinschen.de> <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de> <20091004195723.GH4563@calimero.vinschen.de> <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de> <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de> <20091013102502.GG11169@calimero.vinschen.de>
In-Reply-To: <20091013102502.GG11169@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------020908030902060408050507"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00098.txt.bz2

This is a multi-part message in MIME format.
--------------020908030902060408050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 367

Corinna Vinschen wrote:
> Patch checked in.
>   

Thanks.

> Thanks for doing this.  Would you have fun to provide a tool for the
> net distro which uses this feature?
>
>   

A first try is attached.

cygdrop command ... -- Drop admin group and most privileges and run command.
cygdrop -b command ... -- same, but keep SeBackupPrivilege (~ R/O admin :-)

Christian


--------------020908030902060408050507
Content-Type: text/plain;
 name="cygdrop.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygdrop.cc"
Content-length: 3112

// Drop admin privileges and exec() a command.

#define WINVER 0x0500
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <windows.h>
#include <sys/cygwin.h>

#define SIDSTRUCT(name, auth, n, subauth...) \
  static struct  { \
    BYTE Revision; \
    BYTE SubAuthorityCount; \
    SID_IDENTIFIER_AUTHORITY IdentifierAuthority; \
    DWORD SubAuthority[n]; \
  } name = {SID_REVISION, n, {auth}, {subauth}}

static int
pwinerror(const char * msg)
{
  fprintf(stderr, "%s: %d\n", msg, (int)GetLastError());
  return 1;
}

int
main(int argc, char **argv)
{
  int ac = 1;
  bool b_flag = false;
  if (ac < argc && !strcmp (argv[ac], "-b"))
    {
      b_flag = true;
      ac++;
    }
  if (ac >= argc || argv[ac][0] == '-')
    {
      printf ("Usage: %s [-b] COMMAND [ARG ...]\n"
	      "Drop admin privileges and exec COMMAND\n"
	      "\n"
	      "    -b    keep SeBackupPrivilege\n",
	      argv[0]);
      return 1;
    }

  // Get token
  HANDLE ptoken;
  if(!OpenProcessToken (GetCurrentProcess (), TOKEN_ALL_ACCESS, &ptoken))
    return pwinerror("OpenProcessToken");

  // Get privileges
  const int max_privs = 100;
  char priv_buf[sizeof (DWORD) + sizeof (LUID_AND_ATTRIBUTES) * max_privs];
  TOKEN_PRIVILEGES * privs = (TOKEN_PRIVILEGES *)priv_buf;
  DWORD size = 0;
  if (!GetTokenInformation (ptoken, TokenPrivileges, privs, sizeof(priv_buf), &size))
    return pwinerror ("GetTokenInformation");

  // Collect luids of privileges to disable
  LUID_AND_ATTRIBUTES disable_privs[max_privs];
  int num_disable_privs = 0;
  for (unsigned i = 0; i < privs->PrivilegeCount; i++)
    {
      char name[100];
      size = sizeof(name);
      if (!LookupPrivilegeName (NULL, &privs->Privileges[i].Luid, name, &size))
	return pwinerror ("LookupPrivilegeName");
      if (!strcmp (name, SE_CHANGE_NOTIFY_NAME))
	continue;
      if (!strcmp (name, SE_CREATE_GLOBAL_NAME))
	continue;
      if (b_flag && !strcmp (name, SE_BACKUP_NAME))
	continue;
      disable_privs[num_disable_privs].Luid = privs->Privileges[i].Luid;
      disable_privs[num_disable_privs].Attributes = 0;
      num_disable_privs++;
    }

  // Set SIDs to disable
  const int num_disable_sids = 1;
  SID_AND_ATTRIBUTES disable_sids[num_disable_sids];

  SIDSTRUCT(admins, SECURITY_NT_AUTHORITY, 2, // S-1-5-32-544
            SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS);
  disable_sids[0].Sid = &admins;
  disable_sids[0].Attributes = 0;

  // Create restricted token
  HANDLE rtoken;
  if (!CreateRestrictedToken (ptoken, 0,
                              num_disable_sids, disable_sids,
                              num_disable_privs, disable_privs,
                              0, 0, &rtoken))
    return pwinerror("CreateRestrictedToken");

  CloseHandle (ptoken);

  // Change to restricted token
  if (cygwin_internal (CW_SET_EXTERNAL_TOKEN, rtoken, CW_TOKEN_RESTRICTED))
    {
      perror ("cygwin_internal (CW_SET_EXTERNAL_TOKEN,...)");
      return 1;
    }

  if (setuid (geteuid ()))
    {
      perror ("setuid");
      return 1;
    }

  execvp (argv[ac], argv+ac);
  perror (argv[ac]);
  return 1;
}

--------------020908030902060408050507--
