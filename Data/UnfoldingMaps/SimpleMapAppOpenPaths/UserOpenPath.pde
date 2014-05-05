class UserOpenPath 
{
  // Id of the user
  String id="";

  // Positions retrieved from request to openpath
  // Pvector.x = latitude
  // PVector.y = longitude
  ArrayList<PVector> geoPositions = new ArrayList<PVector>();
  // Number maximum of positions to store in List
  int maxGeoPositions = 400;

  // Object connecting to open path
  // and url of the service
  OAuthService service;
  String URL = "https://openpaths.cc/api/1" ;

  // Time of the last request  
  float timeLastRequest=millis();

  // Is it the first request ? 
  boolean firstRequest = true;

  // Used to query open paths
  long startTimeRequest=0, endTimeRequest=0;

  // Used to trigger the thread or not
  boolean isRequesting = false;

  // Time (in seconds) between each request
  float timeBetweenRequest = 5.0;

  // To track the number of requests made 
  int nbRequests = 0;

  // Debug
  boolean isVerbose = true;

  // ------------------------------------------------------------------------------------------------
  // constructor
  UserOpenPath(String id_, String access_, String secret_)
  {
    this.id = id_;
    this.service = new ServiceBuilder()
      .provider(OpenPathsApi.class)
        .apiKey(access_)
          .apiSecret(secret_)
            .build();
  }

  // ------------------------------------------------------------------------------------------------
  void setVerbose(boolean is_)
  {
    isVerbose = is_;
  }

  // ------------------------------------------------------------------------------------------------
  void setTimeBetweenRequest(float t_)
  {
    timeBetweenRequest = t_;
  }

  // ------------------------------------------------------------------------------------------------
  // Update, used to make regular requests to openpaths 
  void update()
  {
    if (millis() - timeLastRequest >= timeBetweenRequest*1000.0 || firstRequest) {
      request();
    }
  }

  // ------------------------------------------------------------------------------------------------
  void request()
  {
    timeLastRequest = millis();

    // Ok, next time
    if (isRequesting == true) {
      return;
    }

    isRequesting = true;
    new Thread()
    {
      public void run() 
      {
        Token token = new Token("", "");
        OAuthRequest request = new OAuthRequest(Verb.GET, URL);
        service.signRequest(token, request);
        startTimeRequest = firstRequest ? System.currentTimeMillis() / 1000 - 24*60*60 : endTimeRequest;
        endTimeRequest = System.currentTimeMillis() / 1000;

        nbRequests++;
        request.addQuerystringParameter("start_time", String.valueOf(startTimeRequest));
        request.addQuerystringParameter("end_time", String.valueOf(endTimeRequest));
        Response response = request.send();
        if (response.getCode() == 200) 
        {
          if (isVerbose)
            println( id + " : request "+nbRequests+" done." );
          // org.json.JSONArray ja = new org.json.JSONArray(response.getBody());
          JSONArray ja = JSONArray.parse( response.getBody() );
          if (ja != null)
          {
            int nbPositions = ja.size();
            if (isVerbose)
              println( "    - "+ (nbPositions > 0 ? nbPositions+" new position(s)" : " no new position") );
            for (int i = 0; i < nbPositions; i++)
            {
              JSONObject jo = ja.getJSONObject(i);
              PVector pos = new PVector( jo.getFloat("lat"), jo.getFloat("lon") );

              synchronized(geoPositions)
              {
                geoPositions.add(pos);
                if (geoPositions.size()>maxGeoPositions) {
                  geoPositions.remove(0);
                }
              }
            }
          }
          else 
          {
            if (isVerbose)
              println("    - something went wrong in the parsing of data....");
          }
        }
        isRequesting = false;
      }
    }
    .start();

    firstRequest = false;
  }
}

