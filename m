Return-Path: <cygwin-patches-return-1680-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14918 invoked by alias); 12 Jan 2002 18:40:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14892 invoked from network); 12 Jan 2002 18:40:18 -0000
Message-ID: <911C684A29ACD311921800508B7293BA037D29EB@cnmail>
From: Mark Bradshaw <bradshaw@staff.crosswalk.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: [PATCH] mkpasswd.c - Central error reporting
Date: Sat, 12 Jan 2002 10:40:00 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
X-SW-Source: 2002-q1/txt/msg00037.txt.bz2

My changelog is being evil.  

2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>

	* mkpasswd.c (print_win_error): Add a new function, print_win_error,
		that will attempt to get a text message to go along with any
		error code that is passed to it.
	(enum_users): Replace any lines that did error reporting with calls
		to the new function, print_win_error.
	(enum_local_groups): Replace any lines that did error reporting with
		calls to the new function, print_win_error.
	(main): Replace SOME lines that did error reporting with calls
		to the new function, print_win_error.

> -----Original Message-----
> From: Mark Bradshaw 
> Sent: Saturday, January 12, 2002 1:37 PM
> To: 'cygwin-patches@cygwin.com'
> Subject: [PATCH] mkpasswd.c - Central error reporting
> 
> 
> Attempt #2.  As per your request, all network error reporting 
> is centralized in a single function I called print_win_error. 
>  It gets an error code passed to it.  If it can manage to get 
> a text message to go along with the code it will print an 
> error in the form: mkpasswd [error #]: error text
> 
> If it can't get an error message it prints an error in the form:
> mkpasswd: error <error #>
> 
> Print_win_error is called in whatever spots previously had a 
> text error message going out as a result of a network call.  
> Error reporting for incorrect command line usage was left alone.
> 
> Mark
> 
> 
> ===================================================
> 
> 2002-01-12  Mark Bradshaw  <bradshaw@crosswalk.com>
> 
> 	* mkpasswd.c (print_win_error): Add a new function, 
> print_win_error,
> 
> 		that will attempt to get a text message to go 
> along with any
> 
> 		error code that is passed to it.
> 	(enum_users): Replace any lines that did error 
> reporting with calls
> 		to the new function, print_win_error.
> 	(enum_local_groups): Replace any lines that did error 
> reporting with
> 		calls to the new function, print_win_error.
> 	(main): Replace SOME lines that did error reporting with calls
> 		to the new function, print_win_error.
> 	
> 
> ===================================================
> --- mkpasswd.c	Fri Dec 14 15:01:53 2001
> +++ mkpasswd.new.c	Sat Jan 12 13:21:26 2002
> @@ -106,6 +106,22 @@ uni2ansi (LPWSTR wcs, char *mbs, int siz
>      *mbs = '\0';
>  }
>  
> +void
> +print_win_error(DWORD code)
> +{
> +  char buf[4096];
> +
> +  if (FormatMessage (FORMAT_MESSAGE_FROM_SYSTEM
> +      | FORMAT_MESSAGE_IGNORE_INSERTS,
> +      NULL,
> +      code,
> +      MAKELANGID (LANG_NEUTRAL, SUBLANG_DEFAULT),
> +      (LPTSTR) buf, sizeof (buf), NULL))
> +    fprintf (stderr, "mkpasswd [%d]: %s", code, buf);
> +  else
> +    fprintf (stderr, "mkpasswd: error %d", code);
> +}
> +
>  int
>  enum_users (LPWSTR servername, int print_sids, int print_cygpath,
>  	    const char * passed_home_path, int id_offset, char
> *disp_username)
> @@ -139,7 +155,7 @@ enum_users (LPWSTR servername, int print
>        switch (rc)
>  	{
>  	case ERROR_ACCESS_DENIED:
> -	  fprintf (stderr, "Access denied\n");
> +	  print_win_error(rc);
>  	  exit (1);
>  
>  	case ERROR_MORE_DATA:
> @@ -147,9 +163,7 @@ enum_users (LPWSTR servername, int print
>  	  break;
>  
>  	default:
> -	  fprintf (stderr, "NetUserEnum() failed with error 
> %ld.\n", rc);
> -	  if (rc == NERR_UserNotFound) 
> -	    fprintf (stderr, "That user doesn't exist.\n");
> +	  print_win_error(rc);
>  	  exit (1);
>  	}
>  
> @@ -202,11 +216,7 @@ enum_users (LPWSTR servername, int print
>  				      domain_name, &domname_len,
>  				      &acc_type))
>  		{
> -		  fprintf (stderr,
> -			   "LookupAccountName(%s,%s) failed with error
> %ld\n",
> -			   servername ? ansi_srvname : "NULL",
> -			   username,
> -			   GetLastError ());
> +	  	  print_win_error(GetLastError ());
>  		  continue;
>  		}
>  	      else if (acc_type == SidTypeDomain)
> @@ -224,11 +234,7 @@ enum_users (LPWSTR servername, int print
>  					  domain_name, &domname_len,
>  					  &acc_type))
>  		    {
> -		      fprintf (stderr,
> -			       "LookupAccountName(%s,%s) failed 
> with error
> %ld\n",
> -			       servername ? ansi_srvname : "NULL",
> -			       domname,
> -			       GetLastError ());
> +		      print_win_error(GetLastError ());
>  		      continue;
>  		    }
>  		}
> @@ -277,7 +283,7 @@ enum_local_groups (int print_sids)
>        switch (rc)
>  	{
>  	case ERROR_ACCESS_DENIED:
> -	  fprintf (stderr, "Access denied\n");
> +	  print_win_error(rc);
>  	  exit (1);
>  
>  	case ERROR_MORE_DATA:
> @@ -285,7 +291,7 @@ enum_local_groups (int print_sids)
>  	  break;
>  
>  	default:
> -	  fprintf (stderr, "NetLocalGroupEnum() failed with %ld\n", rc);
> +	  print_win_error(rc);
>  	  exit (1);
>  	}
>  
> @@ -305,8 +311,7 @@ enum_local_groups (int print_sids)
>  				  &sid_length, domain_name, 
> &domname_len,
>  				  &acc_type))
>  	    {
> -	      fprintf (stderr, "LookupAccountName(%s) failed 
> with %ld\n",
> -		       localgroup_name, GetLastError ());
> +	      print_win_error(GetLastError ());
>  	      continue;
>  	    }
>  	  else if (acc_type == SidTypeDomain)
> @@ -323,9 +328,7 @@ enum_local_groups (int print_sids)
>  				      domain_name, &domname_len,
>  				      &acc_type))
>  		{
> -		  fprintf (stderr,
> -			   "LookupAccountName(%s) failed with 
> error %ld\n",
> -			   localgroup_name, GetLastError ());
> +		  print_win_error(GetLastError ());
>  		  continue;
>  		}
>  	    }
> @@ -533,8 +536,7 @@ main (int argc, char **argv)
>  
>    if (!load_netapi ())
>      {
> -      fprintf (stderr, "Failed loading symbols from netapi32.dll "
> -		       "with error %lu\n", GetLastError ());
> +      print_win_error(GetLastError ());
>        return 1;
>      }
>  
> @@ -571,7 +573,7 @@ main (int argc, char **argv)
>  
>        if (rc != ERROR_SUCCESS)
>  	{
> -	  fprintf (stderr, "Cannot get DC, code = %ld\n", rc);
> +	  print_win_error(rc);
>  	  exit (1);
>  	}
>  
> 
> 
