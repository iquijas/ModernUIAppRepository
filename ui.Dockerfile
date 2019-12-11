FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY . .
RUN dotnet restore ModernUIApp/ModernUIApp.csproj
RUN dotnet publish ModernUIApp/ModernUIApp.csproj --output /out/ --configuration Release




FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /out .

ENV ApiURL http://modernapiapp/api/customers
ENV ASPNETCORE_ENVIRONMENT Development
ENV LaunchDarklyKey 
EXPOSE 80

ENTRYPOINT ["dotnet", "ModernUIApp.dll"]