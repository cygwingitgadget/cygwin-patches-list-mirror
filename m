From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@sources.redhat.com
Subject: some optimizations
Date: Tue, 17 Oct 2000 20:55:00 -0000
Message-id: <200010180354.XAA17470@envy.delorie.com>
X-SW-Source: 2000-q4/msg00010.html

Using static lookup tables instead of arithmetic, shortcutting
expensive string comparisons, and defering code until it's really
needed.  Shaves about 1.5% off a ../configure.  Comments?

Index: environ.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/environ.cc,v
retrieving revision 1.28
diff -p -2 -r1.28 environ.cc
*** environ.cc	2000/10/16 23:55:57	1.28
--- environ.cc	2000/10/18 03:52:10
*************** static win_env conv_envvars[] =
*** 62,65 ****
--- 62,67 ----
    };
  
+ static unsigned char conv_start_chars[256] = {0};
+ 
  void
  win_env::add_cache (const char *in_posix, const char *in_native)
*************** win_env * __stdcall
*** 92,95 ****
--- 94,100 ----
  getwinenv (const char *env, const char *in_posix)
  {
+   if (!conv_start_chars[(unsigned char)*env])
+     return NULL;
+ 
    for (int i = 0; conv_envvars[i].name != NULL; i++)
      if (strncasematch (env, conv_envvars[i].name, conv_envvars[i].namelen))
*************** posify (char **here, const char *value)
*** 114,118 ****
    char *src = *here;
    win_env *conv;
!   int len = strcspn (src, "=") + 1;
  
    if (!(conv = getwinenv (src)))
--- 119,123 ----
    char *src = *here;
    win_env *conv;
!   int len;
  
    if (!(conv = getwinenv (src)))
*************** posify (char **here, const char *value)
*** 122,125 ****
--- 127,132 ----
       mounted equivalents - if there is one.  */
  
+   len = strcspn (src, "=") + 1;
+ 
    char *outenv = (char *) malloc (1 + len + conv->posix_len (value));
    memcpy (outenv, src, len);
*************** environ_init (char **envp, int envc)
*** 528,531 ****
--- 535,549 ----
    static char cygterm[] = "TERM=cygwin";
  
+   static int initted = 0;
+   if (!initted)
+     {
+       for (int i = 0; conv_envvars[i].name != NULL; i++)
+ 	{
+ 	  conv_start_chars[tolower(conv_envvars[i].name[0])] = 1;
+ 	  conv_start_chars[toupper(conv_envvars[i].name[0])] = 1;
+ 	}
+       initted = 1;
+     }
+ 
    regopt ("default");
    if (myself->progname[0])
*************** environ_init (char **envp, int envc)
*** 571,579 ****
        if (!parent_alive)
  	ucenv (newp, eq);
!       if (strncmp (newp, "TERM=", 5) == 0)
  	sawTERM = 1;
!       if (strncmp (newp, "CYGWIN=", sizeof("CYGWIN=") - 1) == 0)
  	parse_options (newp + sizeof("CYGWIN=") - 1);
!       if (*eq)
  	posify (envp + i, *++eq ? eq : --eq);
        debug_printf ("%s", envp[i]);
--- 589,597 ----
        if (!parent_alive)
  	ucenv (newp, eq);
!       if (*newp == 'T' && strncmp (newp, "TERM=", 5) == 0)
  	sawTERM = 1;
!       if (*newp == 'C' && strncmp (newp, "CYGWIN=", sizeof("CYGWIN=") - 1) == 0)
  	parse_options (newp + sizeof("CYGWIN=") - 1);
!       if (*eq && conv_start_chars[(unsigned char)envp[i][0]])
  	posify (envp + i, *++eq ? eq : --eq);
        debug_printf ("%s", envp[i]);
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.71
diff -p -2 -r1.71 path.cc
*** path.cc	2000/10/17 01:46:26	1.71
--- path.cc	2000/10/18 03:52:11
*************** cygwin_split_path (const char *path, cha
*** 2765,2770 ****
  /********************** String Helper Functions ************************/
  
  #define CHXOR ('a' ^ 'A')
! #define ch_case_eq(ch1, ch2) \
      ({ \
        unsigned char x; \
--- 2765,2789 ----
  /********************** String Helper Functions ************************/
  
+ static char case_folded[] = {
+    0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,  15,
+   16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  26,  27,  28,  29,  30,  31,
+   32, '!', '"', '#', '$', '%', '&',  39, '(', ')', '*', '+', ',', '-', '.', '/',
+  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?',
+  '@', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
+  'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '[',  92, ']', '^', '_',
+  '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
+  'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~', 127,
+  128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143,
+  144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
+  160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175,
+  176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191,
+  192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207,
+  208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223,
+  224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
+  240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 255
+ };
+ 
  #define CHXOR ('a' ^ 'A')
! #define old_ch_case_eq(ch1, ch2) \
      ({ \
        unsigned char x; \
*************** cygwin_split_path (const char *path, cha
*** 2772,2775 ****
--- 2791,2798 ----
         (x != CHXOR || !isalpha (ch1))); \
      })
+ 
+ // This is about 10% faster than the above logic, on average
+ #define ch_case_eq(ch1, ch2) (case_folded[(unsigned char)(ch1)] \
+ 				== case_folded[(unsigned char)(ch2)])
  
  /* Return TRUE if two strings match up to length n */
