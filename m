Return-Path: <cygwin-patches-return-3745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11637 invoked by alias); 26 Mar 2003 19:42:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11623 invoked from network); 26 Mar 2003 19:42:25 -0000
From: "Chris January" <chris@atomice.net>
To: "Cygwin-Patches@Cygwin.Com" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] performance patch for /proc/registry -- version 2
Date: Wed, 26 Mar 2003 19:42:00 -0000
Message-ID: <LPEHIHGCJOAIPFLADJAHAEHODHAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
In-Reply-To: <3E81B568.9040107@hekimian.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
X-SW-Source: 2003-q1/txt/msg00394.txt.bz2

How common are ACLs > 4096 bytes? Could you try calling RegKeyGetSecurity
twice? First with a length of 0. Then RegKeyGetSecurity will set length to
the required buffer size which you can allocate dynamically using new.

Chris

> Here is a second version of the patch, with the code indented
> properly -- no other changes.  I just ran "indent -nut" on it
> after looking around for Cygwin coding standards info.
>
> 2003-03-25  Joe Buehler  <jhpb@draco.hekimian.com>
>
> 	* autoload.cc: added RegGetKeySecurity()
> 	* security.cc (get_nt_object_attribute): use
> RegGetKeySecurity() for performance.
>
> Index: autoload.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
> retrieving revision 1.65
> diff -u -r1.65 autoload.cc
> --- autoload.cc	13 Mar 2003 22:53:15 -0000	1.65
> +++ autoload.cc	25 Mar 2003 19:28:24 -0000
> @@ -375,6 +373,7 @@
>   LoadDLLfunc (SetSecurityDescriptorGroup, 12, advapi32)
>   LoadDLLfunc (SetSecurityDescriptorOwner, 12, advapi32)
>   LoadDLLfunc (SetTokenInformation, 16, advapi32)
> +LoadDLLfunc (RegGetKeySecurity, 16, advapi32)
>
>   LoadDLLfunc (NetApiBufferFree, 4, netapi32)
>   LoadDLLfuncEx (NetGetDCName, 12, netapi32, 1)
> Index: security.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/security.cc,v
> retrieving revision 1.141
> diff -u -r1.141 security.cc
> --- security.cc	19 Mar 2003 21:34:38 -0000	1.141
> +++ security.cc	26 Mar 2003 14:08:30 -0000
> @@ -1443,19 +1444,73 @@
>     PSECURITY_DESCRIPTOR psd = NULL;
>     cygpsid owner_sid;
>     cygpsid group_sid;
> -  PACL acl;
> +  PACL acl = NULL;
>
> -  if (ERROR_SUCCESS != GetSecurityInfo (handle, object_type,
> -					DACL_SECURITY_INFORMATION |
> -					GROUP_SECURITY_INFORMATION |
> -					OWNER_SECURITY_INFORMATION,
> -					(PSID *) &owner_sid,
> -					(PSID *) &group_sid,
> -					&acl, NULL, &psd))
> +  if (object_type == SE_REGISTRY_KEY)
>       {
> -      __seterrno ();
> -      debug_printf ("GetSecurityInfo %E");
> -      return -1;
> +      // use different code for registry handles, for performance reasons
> +      char sd_buf[4096];
> +      PSECURITY_DESCRIPTOR psd2 = (PSECURITY_DESCRIPTOR) & sd_buf[0];
> +      DWORD len = sizeof (sd_buf);
> +      if (ERROR_SUCCESS != RegGetKeySecurity ((HKEY) handle,
> +                                              DACL_SECURITY_INFORMATION |
> +
> GROUP_SECURITY_INFORMATION |
> +                                              OWNER_SECURITY_INFORMATION,
> +                                              psd2, &len))
> +        {
> +          __seterrno ();
> +          debug_printf ("RegGetKeySecurity %E");
> +          return -1;
> +        }
> +
> +      BOOL bDaclPresent;
> +      BOOL bDaclDefaulted;
> +      if (!GetSecurityDescriptorDacl (psd2,
> +                                      &bDaclPresent, &acl,
> &bDaclDefaulted))
> +        {
> +          __seterrno ();
> +          debug_printf ("GetSecurityDescriptorDacl %E");
> +          return -1;
> +        }
> +      if (!bDaclPresent)
> +        {
> +          acl = NULL;
> +        }
> +
> +      BOOL bGroupDefaulted;
> +      if (!GetSecurityDescriptorGroup (psd2,
> +                                       (PSID *) & group_sid,
> +                                       &bGroupDefaulted))
> +        {
> +          __seterrno ();
> +          debug_printf ("GetSecurityDescriptorGroup %E");
> +          return -1;
> +        }
> +
> +      BOOL bOwnerDefaulted;
> +      if (!GetSecurityDescriptorOwner (psd2,
> +                                       (PSID *) & owner_sid,
> +                                       &bOwnerDefaulted))
> +        {
> +          __seterrno ();
> +          debug_printf ("GetSecurityDescriptorOwner %E");
> +          return -1;
> +        }
> +    }
> +  else
> +    {
> +      if (ERROR_SUCCESS != GetSecurityInfo (handle, object_type,
> +                                            DACL_SECURITY_INFORMATION |
> +                                            GROUP_SECURITY_INFORMATION |
> +                                            OWNER_SECURITY_INFORMATION,
> +                                            (PSID *) & owner_sid,
> +                                            (PSID *) & group_sid,
> +                                            &acl, NULL, &psd))
> +        {
> +          __seterrno ();
> +          debug_printf ("GetSecurityInfo %E");
> +          return -1;
> +        }
>       }
>
>     __uid32_t uid;
> --
> Joe Buehler
